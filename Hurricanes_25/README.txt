This readme.txt file was generated on 2021-05-15 by Gabriel Vecchi

GENERAL INFORMATION

1. Title of Dataset: North Atlantic Hurricane and Major Hurricane Frequency Undersampling Estimate for 1851-2019

2. Author Information
	A. Principal Investigator Contact Information
		Name: Gabriel A. Vecchi 
		Institution: Princeton University
		Address: Department of Geosciences, Princeton, NJ 08544
		Email: gvecchi@princeton.edu


3. Date of data collection: 1851-01-01 through 2019-01-01 

4. Geographic location of data collection: North Atlantic hurricane basin, Continental United States

5. Information about funding sources that supported the collection of the data: 
This work has been supported by NOAA/OCO (award NA18OAR4310418), the Cooperative Institute for Modeling the Earth System (CIMES; NOAA award NA18OAR4320123) at Princeton University, and the Carbon Mitigation Initiative (CMI) at Princeton University, the National Science Foundation under Grant EARâ€1840742 and USACE Institute for Water Resources.

SHARING/ACCESS INFORMATION

1. Licenses/restrictions placed on the data: N/A

2. Links to publications that cite or use the data: 
Vecchi, Landsea, Zhang, Villarini and Knutson (2021): Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century. Nature Communications.

3. Links to other publicly accessible locations of the data: N/A

4. Links/relationships to ancillary data sets: N/A

5. Was data derived from another source? yes/no
	A. If yes, list source(s): 
US striking and recorded hurricane data based on HURDAT2: Landsea, C. W., and J. L. Franklin, 2013: Atlantic Hurricane Database Uncertainty and Presentation of a New Database Format. Mon. Wea. Rev., 141, 3576-3592.
https://www.nhc.noaa.gov/data/#hurdat

6. Recommended citation for this dataset: 
Vecchi, Landsea, Zhang, Villarini and Knutson (2021): Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century. Nature Communications.
AND
Vecchi, G.A., C. Landsea, W. Zhang, G. Villarini and T. Knutson (2021): North Atlantic Hurricane and Major Hurricane Frequency Undersampling Estimate for 1851-2019. Princeton DataSpace.

DATA & FILE OVERVIEW

1. File List: 
# NetCDF Files:
# 
# HURDAT2 US land striking hurricane and major hurricane frequency:
	landfall.nc
#
# HURDAT2 North Atlantic hurricane recorded frequency (does not include missing storm correction):
	recorded_hurricanes.nc
#
# HURDAT2 North Atlantic major hurricane recorded frequency (does not include missing storm correction):
	obs_major.nc
#
# 10,000 member bootstrap resampling of the hurricane frequency adjustment (to be added to observed frequency).
# Each ensemble member is an equally plausible timeseries of hurricane frequency adjusment.
	hu_bootstrap_correction.nc
#
# 10,000 member bootstrap resampling of the major hurricane frequency adjustment (to be added to observed frequency).
# Each ensemble member is an equally plausible timeseries of major hurricane frequency adjusment.
	mh_bootstrap_correction.nc
#
# The median, mean, 2.5% and 97.5% ranges of the Boostrap Corrected (recorded+correction) frequency of hurricanes (HU)
# and major hurricanes (mh) for annual (sbx1) and 15-year (sbx15) data.
	HU_sbx15_ranges.nc
	HU_sbx1_ranges.nc
	mh_sbx15_ranges.nc
	mh_sbx1_ranges.nc
#
# All the correction values arranged based on satellite year (1972-2019), storm size random seed (1-100) and 
# time shift of the ship tracks (-50, -45, -40,..,45, 50) for each pre-satellite era (1851-1971) year.
	hu_missed_all.nc
	mh_missed_all.nc
#
#
# In the ZIP file "Timeseries_Models.zip" are the scripts and data necessary to generate the two 
# tables in Vecchi et al. (2021, Nature Communications).
#
# In the ZIP file "PLOTTING_SCRIPTS.zip" are the scripts necessary to generate each of the figures using
# PyFerret (https://ferret.pmel.noaa.gov/Ferret/documentation/pyferret)
#
# Figure 1 is the recorded hurricane and strike record
echo go MAKE_FIG1.jnl | pyferret

# Figure 2a.c are the adjustments and adjusted hurricane counts 
echo go MAKE_FIG2ac.jnl 1 | pyferret  #Makes Fig. 2a - need to make sure vlimits go to 20 in first plot
echo go MAKE_FIG2ac.jnl 15 | pyferret  #Makes Fig. 2c - need to make sure vlimits go to 12 in first plot

# Figure 2b.d are the adjustments and adjusted major hurricane counts 
echo go MAKE_FIG2bd.jnl 1 | pyferret  #Makes Fig. 2a - need to make sure vlimits go to 9.5 in first plot
echo go MAKE_FIG2bd.jnl 15 | pyferret  #Makes Fig. 2c - need to make sure vlimits go to 5 in first plot

# Figure 3 is the ratio of the 15-year running strike fractions
echo go MAKE_FIG3a.jnl 15 | pyferret # Makes Fig. 3a - for hurricanes
echo go MAKE_FIG3b.jnl 15 | pyferret # Makes Fig. 3b - for major hurricanes

# Figure 4 is the ratio of 15-year majors to hurricanes basinwide
echo go MAKE_FIG4.jnl 15 | pyferret
##
# Supplementary Figures.
#
# These scripts make the Supplementary Figures, which are leave-K-out subsamplings of the correction for hurricane and major hurricanes
#
echo go LEAVE_OUT_Keq12_SATELLITE_HU.jnl | pyferret
echo go LEAVE_OUT_Keq8_SATELLITE_HU.jnl | pyferret
echo go LEAVE_OUT_Keq6_SATELLITE_HU.jnl | pyferret
#
echo go LEAVE_OUT_Keq12_SATELLITE_MH.jnl | pyferret
echo go LEAVE_OUT_Keq8_SATELLITE_MH.jnl | pyferret
echo go LEAVE_OUT_Keq6_SATELLITE_MH.jnl | pyferret
##

2. Relationship between files, if important: N/A

3. Additional related data collected that was not included in the current data package:  N/A

4. Are there multiple versions of the dataset? NO
	A. If yes, name of file(s) that was updated: 
		i. Why was the file updated? N/A
		ii. When was the file updated? N/A


METHODOLOGICAL INFORMATION

1. Description of methods used for collection/generation of data: 
Methods described Vecchi, Landsea, Zhang, Villarini and Knutson (2021): Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century. Nature Communications.

2. Methods for processing the data: 
Methods described in Vecchi, Landsea, Zhang, Villarini and Knutson (2021): Changes in Atlantic Major Hurricane Frequency Since the Late-19th Century. Nature Communications.

3. Instrument- or software-specific information needed to interpret the data: N/A

4. Standards and calibration information, if appropriate: N/A

5. Environmental/experimental conditions: N/A

6. Describe any quality-assurance procedures performed on the data: 
Data was copied from original location and scripts rerun to assess that the output matched original.

7. People involved with sample collection, processing, analysis and/or submission: 
Gabriel Vecchi, Chris Landsea

DATA-SPECIFIC INFORMATION FOR: landfall.nc
1. Number of variables: 2
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
USHU - US land striking hurricanes from HURDAT2 (Landsea and Franklin 2013)
USMA - US land striking major hurricanes from HURDAT2 (Landsea and Franklin 2013)
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: recorded_hurricanes.nc
1. Number of variables: 2
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
HU - North Atlantic basin wide annual hurricane frequency on time axis from HURDAT2 (Landsea and Franklin 2013)
HU_ON_Y - North Atlantic basin wide annual hurricane frequency with time axis on the y axis from HURDAT2 (Landsea and Franklin 2013)
4. Missing data codes: 
-1.e+34

5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)
DATA-SPECIFIC INFORMATION FOR: obs_major.nc
1. Number of variables: 2
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
OBS_MAJOR - North Atlantic basin wide annual major hurricane frequency on time axis from HURDAT2 (Landsea and Franklin 2013)
OBS_MAJOR_ON_Y - North Atlantic basin wide annual major hurricane frequency with time axis on the y axis from HURDAT2 (Landsea and Franklin 2013)
4. Missing data codes: 
-1.e+34

5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)
DATA-SPECIFIC INFORMATION FOR: hu_bootstrap_correction.nc
1. Number of variables: 2
2. Number of cases/rows: 10,000 (bootstrap samples) x 169 (each year 1851-2019)
3. Variable List: 
SEED: The random seed used to generate the Bootstrap sample of each element
BOOTMISS40: The number of basin wide Atlantic hurricane frequency to be added to the recorded HURDAT2 hurricane count for each Bootstrap sample and each year.
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: mh_bootstrap_correction.nc
1. Number of variables: 2
2. Number of cases/rows: 10,000 (bootstrap samples) x 169 (each year 1851-2019)
3. Variable List: 
SEED: The random seed used to generate the Bootstrap sample of each element
BOOTMISS: The number of basin wide Atlantic major hurricane frequency to be added to the recorded HURDAT2 major hurricane count for each Bootstrap sample and each year.
4. Missing data codes: 
-1.e+34

5. Specialized formats or other abbreviations used:
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)
DATA-SPECIFIC INFORMATION FOR: HU_sbx1_ranges.nc
1. Number of variables: 3
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
P5_SBX1: Median from Bootstrap of adjusted North Atlantic annual hurricane frequency
P025_SBX1: 2.5% range from Bootstrap of adjusted North Atlantic annual hurricane frequency
P975_SBX1: 97.5% range from Bootstrap adjusted North Atlantic annual hurricane frequency
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: HU_sbx15_ranges.nc
1. Number of variables: 3
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
P5_SBX15: Median from Bootstrap of adjusted North Atlantic running 15-Year hurricane frequency
P025_SBX15: 2.5% range from Bootstrap of adjusted North Atlantic running 15-Year hurricane frequency
P975_SBX15: 97.5% range from Bootstrap adjusted North Atlantic running 15-Year hurricane frequency
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: MH_sbx1_ranges.nc
1. Number of variables: 3
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
P5_SBX1: Median from Bootstrap of adjusted North Atlantic annual major hurricane frequency
P025_SBX1: 2.5% range from Bootstrap of adjusted North Atlantic annual major hurricane frequency
P975_SBX1: 97.5% range from Bootstrap adjusted North Atlantic annual major hurricane frequency
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: HU_sbx1_ranges.nc
1. Number of variables: 3
2. Number of cases/rows: 169 (each year 1851-2019)
3. Variable List: 
P5_SBX1: Median from Bootstrap of adjusted North Atlantic hurricane annual hurricane frequency
P025_SBX1: 2.5% range from Bootstrap of adjusted North Atlantic hurricane annual hurricane frequency
P975_SBX1: 97.5% range from Bootstrap adjusted North Atlantic hurricane annual hurricane frequency
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: hu_missed_all.nc
1. Number of variables: 2
2. Number of cases/rows: 48 (for each satellite era year 1972-2019) x 227 (each year 1851-2006) x 21 (shifting the day of the ships by -50, -45, -40...,50 days) x 100 (100 random seeds for storm size)
3. Variable List:
MISS: the number of hurricanes not seen from each satellite era year, for each pre-satellite era year, by shifting the day of ship obs by a certain number of days, and using 100 different random seeds for storm size - no latitude cutoff on detection.
MISS40: the number of hurricanes not seen from each satellite era year, for each pre-satellite era year, by shifting the day of ship obs by a certain number of days, and using 100 different random seeds for storm size - first detection must be equatorward of 40N
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)

DATA-SPECIFIC INFORMATION FOR: mh_missed_all.nc
1. Number of variables: 1
2. Number of cases/rows: 48 (for each satellite era year 1972-2019) x 227 (each year 1851-2006) x 21 (shifting the day of the ships by -50, -45, -40...,50 days) x 100 (100 random seeds for storm size)
3. Variable List:
MISS: the number of major hurricanes not seen from each satellite era year, for each pre-satellite era year, by shifting the day of ship obs by a certain number of days, and using 100 different random seeds for storm size - no latitude cutoff on detection.
4. Missing data codes: 
-1.e+34
5. Specialized formats or other abbreviations used: 
Data in NetCDF format (https://www.unidata.ucar.edu/software/netcdf/)