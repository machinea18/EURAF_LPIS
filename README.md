# EURAF_LPIS
Welcome to the GitHub repository for the DIGITAF COPERNICUS and LPIS integrator workpackage. This repository is an easy way to access shared code for the processing of data. 


The project is split into the the following steps:

1) Calculation of %TCD on EU-27 cropland 10m raster (annual and permanent)
2) Calculation of %TCD on EU-27 grassland
3) Calculation of %TCD on EU-27 forestland (JRC) 10m raster data
4) Comparison of crop, grass and forest Copernicus 10m raster data
5) TCD% values for each LPIS parcel

Code will be labelled according to the following steps with the following notified at the beginning of the file "stepx_", where x represents the relevant step. Where more than one step is relevant x will be a two digit number representing the first and last relevant steps.

This readme file will be regularly updated with progress regarding relevant code as well as results, where relevant.

#25/09/2025
Initial code for step 5 written, with comments to denote user inputs. Currently undergoing a process to download the raster layers and merge them into a singular VRT for each dataproduct.
