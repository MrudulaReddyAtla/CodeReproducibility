library(gamlss)

# This calculates a Binomial regression against time (logistic link) for the 
# various hurricane and major hurricane time series for Table 2 in:
# Vecchi, Landsea, Zhang, Villarini and Knutson (2021):
# Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century. 
# Nature Communications.
#
# Change in "mod.sel..." line the variable that is fit to "year" in order
# to build models for various data: e.g., ushu, usma, etc.

# open dataset 
oth.data <-read.table("~/Documents/Huriicanes_25/Timeseries_Models/year_ushu_usma_h2hu_h2ma_adju_adma_1878")

# define variables from input data

x <- oth.data[,1]
year <- oth.data[,1]/100
ushu <- oth.data[,2]
usma <- oth.data[,3]
h2hu <- oth.data[,4]
h2ma <- oth.data[,5]
adhu <- oth.data[,6]
adma <- oth.data[,7]

alls <- adhu
some <- adma
y <- cbind(some, alls-some)
colnames(y) <- c("r", "n-r")
# Perform Binomial regression (specifying family as "BI") of y on time
mod.sel <- gamlss(y ~ year,family=BI) 

# Make a plot of the median and various percentiles of the fit
centiles(mod.sel,xvar=x,cent = c(5,25,50,75,95),col="black",pch="o")

summary(mod.sel)    #summary of the model

plot(mod.sel)           #set of plots with residuals

wp(mod.sel,ylim.all=1.5)            #worm-plots
