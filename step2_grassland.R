#processing EU wide grasslands
library(terra)
#lading the datasets
grass <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grassland")
TCD <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD10m")

#note thatgrass seems to only have 3 labels: 0 - no grass, 1- grass, 255 - NA
#has %1-100 and 255 for NA
#changing this to 0 for no grass and 1 for grass
grass <- resample(grass, TCD, method = "near")
grass <- classify(grass, rcl = matrix(c(0, 0, 0,
                                        0, 1, 1,
                                        254, 256, 0), 
                                      ncol = 3, byrow=TRUE
))

TCD <- classify(TCD, rcl = matrix(c(0, 0, 0,
                                        1, 5, 1,
                                        5, 10, 2,
                                    10, 20, 3,
                                    20, 50, 4,
                                    50, 100, 5,
                                    254, 256, 0), 
                                      ncol = 3, byrow=TRUE
))
#raster calculator on the final product

grass_agroforestry <- grass + (grass*TCD)
#1 = grass 0%, 2 = 1-5%, 3= 6-10%, 4 = 11-20%, 5 = 21-50%, 6 = 51=100%
NAflag(grass_agroforestry) <- 0

#writing this
#getting tile sizes
nrow(grass_agroforestry)/32
ncol(grass_agroforestry)/26
#saving a bunch of tiles
makeTiles(grass_agroforestry, y = c(14375,25000), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grass_agroforestry/tile_.tif",
          na.rm = TRUE, extend = TRUE)

files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grass_agroforestry/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_grass")

#testing that everything looks fine
grass_ag <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_grass")

