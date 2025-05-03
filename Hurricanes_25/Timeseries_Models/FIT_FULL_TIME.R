library(gamlss)

# This calculates a Poisson regression against time (log link) for the 
# various hurricane and major hurricane time series for Table 1 in: 
# Vecchi, Landsea, Zhang, Villarini and Knutson (2021): 
# Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century.
# Nature Communications.
#
# Change in "mod.sel..." line the variable that is fit to "year" in order
# to build models for various data: e.g., ushu, usma, etc.

set.seed(1234)
# Open dataset
oth.data <-read.table("/Users/vecchigabe/Documents/Papers/2021_Vecchi_Recount_Majors/Revision2/Timeseries_Models/year_ushu_usma_h2hu_h2ma_adju_adma") 

# define variables from input data

x <- oth.data[,1]
year <- oth.data[,1]/100
ushu <- oth.data[,2]
usma <- oth.data[,3]
h2hu <- oth.data[,4]
h2ma <- oth.data[,5]
adhu <- oth.data[,6]
adma <- oth.data[,7]

# Perform Poisson regression (specifying family as "PO") of y based on x1 and x2
mod.sel <- gamlss(adma ~year,family=PO) 

# Make a plot of the median and various percentiles of the fit
centiles(mod.sel,xvar=x,cent = c(5,25,50,75,95),col="black",pch="o")

summary(mod.sel)    #summary of the model

plot(mod.sel)           #set of plots with residuals

wp(mod.sel,ylim.all=1.5)            #worm-plots
