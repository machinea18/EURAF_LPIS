#loading relevant packages
library(terra)
library(parallel) #package for parallel processing

#files, please input oaths manually
parcels <- vect("PATH1") #LPIS parcels
TCD10m <- rast("PATH4") #copernicus TCD layer, likely VRT
numcores <- 1 #change this to reflect the number of cores you will be using
agriculture <- c("LIST") #this is the list of codes to include as agriculture



parcel_processing <- function(parcels, x) {
  #using the zonal function to get the weighted mean of tree cover
  #weights means that the fraction of the overlap in the polygon is also relevant
  #so if a pixels only overlaps 50% its weight will only be 50%
  return(zonal(TCD10m, parcels[x,], weights = TRUE))
  if(parcels$CODE %in% agriculture) { #NOTE $CODE must be replaced with the 
    #column name of the LPIS code
    return(zonal(TCD10m, parcels[x,], weights = TRUE))
  } else {
    return(NA)
  }
}

#note this code does not work on a windows computer. It will run with only one core
results <- mclapply(X = 1:length(parcels), FUN = parcel_processing,
                           parcels = parcels,
                          mc.cores = numcores)
results<- unlist(results)

write.csv(results, "FILEANME.csv") #please change filename 

#this outputs a one column CSV file that can then be attached back to the LPIS data
