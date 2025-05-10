# Reset Bioconductor environment for SingleCellExperiment compatibility

# Remove problematic packages
pkgs_to_remove <- c(
  "SingleCellExperiment", "SummarizedExperiment", "S4Vectors",
  "BiocGenerics", "Matrix", "scuttle", "DelayedArray", "IRanges"
)

for (pkg in pkgs_to_remove) {
  if (pkg %in% rownames(installed.packages())) {
    message(paste("Removing:", pkg))
    remove.packages(pkg)
  }
}

# Install BiocManager if not already present
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Reinstall Bioconductor core and relevant packages
BiocManager::install(version = "3.18")

BiocManager::install(c(
  "SingleCellExperiment", "SummarizedExperiment", "S4Vectors",
  "BiocGenerics", "Matrix", "scuttle", "DelayedArray", "IRanges",
  "DropletUtils", "scater"
), ask = FALSE, force = TRUE)

# Load libraries to confirm installation
library(SingleCellExperiment)
library(SummarizedExperiment)
library(DropletUtils)
library(scater)

# Test read10xCounts (customize path as needed)
# cd4.t <- read10xCounts("./raw/filtered_matrices_mex_memory/hg19")
# print(cd4.t)
