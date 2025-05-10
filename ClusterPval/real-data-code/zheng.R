# Install BiocManager if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install required packages if not present
required_pkgs <- c("SingleCellExperiment", "SummarizedExperiment", "DropletUtils", 
                   "scater", "clusterpval", "fastcluster", "ggfortify", "patchwork")

for (pkg in required_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, ask = FALSE, update = TRUE)
  }
}

# Load libraries in the correct order
library(SingleCellExperiment)
library(SummarizedExperiment)
library(DropletUtils)
library(scater)
library(clusterpval)
library(fastcluster)
library(ggfortify)
library(patchwork)

# Clean environment to avoid class definition issues
rm(list = ls())
gc()

set.seed(1)

source("util.R")

##### Pre-processing and splitting data #### 
cd4.t <- read10xCounts("./raw/filtered_matrices_mex_memory/hg19")
cd19.b <- read10xCounts("./raw/filtered_matrices_mex_bcell/hg19")
mono <-  read10xCounts("./raw/filtered_matrices_mex_mono/hg19")

pure.t <- cd4.t
colData(pure.t)$CellType <- c(rep("Memory T cell", ncol(cd4.t)))

mix3 <- cbind(cd4.t, cd19.b, mono)
colData(mix3)$CellType <- c(rep("Memory T cell", ncol(cd4.t)), 
                            rep("B cell", ncol(cd19.b)), 
                            rep("Monocyte", ncol(mono)))

process_data <- function(sce) { 
  rowData(sce)$Mito <- grepl("^MT", rowData(sce)$Symbol)
  rowData(sce)$ProteinRibo <- grepl("^RP", rowData(sce)$Symbol)
  
  sce <- addPerCellQC(sce, subsets=list(mt=rowData(sce)$Mito, rbp=rowData(sce)$ProteinRibo))
  sce <- addPerFeatureQC(sce)
  
  libsize.drop <- isOutlier(sce$sum, nmads = 3, type = "lower", log = TRUE)
  feature.drop <- isOutlier(sce$detected, nmads = 3, type = "both", log = TRUE)
  mito.drop <- isOutlier(sce$subsets_mt_percent, nmads = 3, type = "higher", log = TRUE)
  sce <- sce[,!(libsize.drop | feature.drop |mito.drop)]
  
  sce <- logNormCounts(sce)
  X <- t(logcounts(sce))
  X <- as.matrix(X)
  X <- X[,  order(rowData(sce)$mean, decreasing=T)[1:500]]
  return(list(data=X, labels=colData(sce)$CellType))
}

processed.t <- process_data(pure.t)
ss.id.null <- sample(1:nrow(processed.t$data), 600)
X1 <- processed.t$data[ss.id.null, ]
X1.ss <- processed.t$data[setdiff(1:nrow(processed.t$data), ss.id.null), ]

processed.mix3 <- process_data(mix3)
tcell.id <- which(processed.mix3$labels == "Memory T cell")
bcell.id <- which(processed.mix3$labels == "B cell")
mono.id <- which(processed.mix3$labels == "Monocyte")

ss.id <- c(sample(tcell.id, 200), sample(bcell.id, 200), 
           sample(mono.id, 200))
X2 <- processed.mix3$data[ss.id, ]
X2.ss <- processed.mix3$data[setdiff(1:nrow(processed.mix3$data), ss.id), ]

##### Data analysis #### 
hcl <- hclust(dist(X1)^2, method="ward.D")
plot(hcl)
K <- 3

pca_data <- prcomp(X1, rank=2)
ggplot(pca_data$x, aes(x=PC1, y=PC2, colour=as.factor(cutree(hcl, K)))) + geom_point() +
  coord_fixed(ratio=1.38/3.33) + ggtitle("Negative control") + ylab("PC2") +
  xlab("PC1") + scale_colour_discrete(name="Estimated clusters")  +  theme_bw(base_size=22)  +
  theme(legend.position="bottom")

SampleCovX1 <- cov(X1.ss)
EigenSampleCovX1 <- eigen(SampleCovX1)
EigenSampleCovX1$values[1:10]

p <- ncol(X1.ss)
SigX <- POET(t(scale(X1.ss, scale=FALSE)), K=5, C=0.5, thres="soft", "vad")
Su <- SigX$SigmaU
B <- SigX$loadings
SuInv <- solve(Su)

SigX1 <- B%*%t(B) + Su
SigXInv1 <- SuInv - SuInv%*%B%*%solve(diag(5) + t(B)%*%SuInv%*%B)%*%t(B)%*%SuInv

wald_test(X1, link="ward.D", K=3, k1=1, k2=2, iso=FALSE, SigInv=SigXInv1)
wald_test(X1, link="ward.D", K=3, k1=1, k2=3, iso=FALSE, SigInv=SigXInv1)
wald_test(X1, link="ward.D", K=3, k1=2, k2=3, iso=FALSE, SigInv=SigXInv1)

test_hier_clusters_exact(X1, link="ward.D", K=3, k1=1, k2=2, iso=FALSE, SigInv=SigXInv1, hcl=hcl)
test_hier_clusters_exact(X1, link="ward.D", K=3, k1=1, k2=3, iso=FALSE, SigInv=SigXInv1, hcl=hcl)
test_hier_clusters_exact(X1, link="ward.D", K=3, k1=2, k2=3, iso=FALSE, SigInv=SigXInv1, hcl=hcl)

rm(SigX)
rm(Su)
rm(B)
rm(SuInv)
rm(SigX1)
rm(SigXInv1)

pca_data2 <- prcomp(X2, rank=2)
pca_data2$x <- data.frame(PC1=pca_data2$x[, 1], PC2=pca_data2$x[, 2], CellType=colData(mix3)$CellType)
ggplot(pca_data2$x, aes(x=PC1, y=PC2, colour=CellType)) + geom_point() +
  coord_fixed(ratio=6.84/18.23) + ggtitle("Positive control") + xlab("PC2") +
  ylab("PC1") + scale_color_brewer(palette="Dark2", name="Cell types") + theme_bw(base_size=22)  +
  theme(legend.position="bottom") + guides(colour = guide_legend(nrow =2))

hcl2 <- hclust(dist(X2)^2, method="ward.D")
K <- 3
table(processed.mix3$labels[ss.id], cutree(hcl2, K))

SampleCovX2 <- cov(X2.ss)
EigenSampleCovX2 <- eigen(SampleCovX2)
EigenSampleCovX2$values[1:10]

p <- ncol(X2.ss)
SigX <- POET(t(scale(X2.ss, scale=F)), K=5, C=0.5, thres="soft", "vad")
Su <- SigX$SigmaU
B <- SigX$loadings
SuInv <- solve(Su)

SigX2 <- B%*%t(B) + Su
SigXInv2 <- SuInv - SuInv%*%B%*%solve(diag(5) + t(B)%*%SuInv%*%B)%*%t(B)%*%SuInv

wald_test(X2, link="ward.D", K=3, k1=1, k2=2, iso=FALSE, SigInv=SigXInv2)
wald_test(X2, link="ward.D", K=3, k1=1, k2=3, iso=FALSE, SigInv=SigXInv2)
wald_test(X2, link="ward.D", K=3, k1=2, k2=3, iso=FALSE, SigInv=SigXInv2)

test_hier_clusters_exact(X2, link="ward.D", K=3, k1=1, k2=2, iso=FALSE, SigInv=SigXInv2, hcl=hcl2)
test_hier_clusters_exact(X2, link="ward.D", K=3, k1=1, k2=3, iso=FALSE, SigInv=SigXInv2, hcl=hcl2)
test_hier_clusters_exact(X2, link="ward.D", K=3, k1=2, k2=3, iso=FALSE, SigInv=SigXInv2, hcl=hcl2)
