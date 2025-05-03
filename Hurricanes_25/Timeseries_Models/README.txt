This directory contains the files necessary to generate the regression parameter
values that are shown in Tables 1 and 2 of:
Vecchi, Landsea, Zhang, Villarini and Knutson (2021): Changes in Atlantic
Major Hurricane Frequency Since the Late-19th Century. Nature Communications.

There are four "R" scripts that are used to compute the Poisson regressions
of count against time as a covariate:
FIT_FULL_TIME.R
FIT_1878_TIME.R
FIT_1900_TIME.R
FIT_1980_TIME.R

Each of those scripts is for a different length period (1851-2019 for "FULL",
1878-2019 for "1878"...). In order to compute the regression paramters for
each count variable, inside the script where the "mod.sel" is asigned, the 
dependent variable XXXXX in "gamlss(XXXXX ~year, family=PO)" needs to be
changed to the variable one is interested in modeling.

There are four "R" scripts that are used to compute the Binomial regressions of
the count of a subset from the count on a greater set (e.g., US hurricanes 
from NA hurricanes) against time.

FIT_FULL_BI_TIME.R
FIT_1878_BI_TIME.R
FIT_1900_BI_TIME.R
FIT_1980_BI_TIME.R

Each of those scripts is for a different length period (1851-2019 for "FULL",
1878-2019 for "1878"...). In order to compute the regression paramters for
different paired count variables, inside the script where the variables
"alls" and "some" are assigned, change the assignment of "alls" to the greater
set (e.g., NA hurricanes) and "some" to the subset (e.g., US hurricanes).

------

The scripts above use ASCII, space delimited data files:
year_ushu_usma_h2hu_h2ma_adju_adma
year_ushu_usma_h2hu_h2ma_adju_adma_1878
year_ushu_usma_h2hu_h2ma_adju_adma_1900
year_ushu_usma_h2hu_h2ma_adju_adma_1980

Each of those files has seven (7) columns, each row for a different year. The 
variables in the columns are:
Column 1: Hurricane Season Year (year of the June-November North Atlantic hurricane season)
Column 2: Seasonal total number of USA striking hurricanes (sustained wind speeds at land strike exceeding 33 m/s)
Column 3: Seasonal total number of USA striking major hurricanes (sustained wind speeds at land strike exceeding 50 m/s)
Column 4: Seasonal total number of North Atlantic basin-wide hurricanes recorded in HURDAT2
Column 5: Seasonal total number of North Atlantic basin-wide major hurricanes recorded in HURDAT2
Column 6: Median seasonal total number of North Atlantic basin-wide hurricanes adjusted for "missing" storms from Vecchi et al. (2021)
Column 6: Median seasonal total number of North Atlantic basin-wide major hurricanes adjusted for "missing" storms from Vecchi et al. (2021)
