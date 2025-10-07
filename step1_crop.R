#processing EU wide grasslands
library(terra)
#lading the datasets
crop <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/cropland")
TCD <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD10m")

#note thatgrass seems to only have 3 labels: 0 - no grass, 1- grass, 255 - NA
#has %1-100 and 255 for NA
#changing this to 0 for no grass and 1 for grass
#crop <- resample(crop2, TCD, method = "near"), cannot do this first
crop <- classify(crop, rcl = matrix(c(0, 0, 0,
                                        1109, 1110, 1,
                                        1119, 1120, 1,
                                        1129, 1130, 1,
                                        1139, 1140, 1,
                                        1149, 1150, 1,
                                      1209, 1210, 1,
                                      1219, 1220, 1,
                                      1309, 1310, 1,
                                      1319, 1320, 1,
                                      1409, 1410, 1,
                                      1419, 1420, 1,
                                      1429, 1430, 1,
                                      1439, 1440, 1,
                                      2099, 2100, 0,
                                      2199, 2200, 0,
                                      2319, 2320, 0,
                                      2309, 2310, 0,
                                      2329, 2330, 0,
                                      3099, 3100, 1,
                                      3199, 3200, 0,
                                      65534, 65546, 0), 
                                      ncol = 3, byrow=TRUE
))
crop <- resample(crop, TCD, method = "near")

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

crop_agroforestry <- crop + (crop*TCD)
#1 = grass 0%, 2 = 1-5%, 3= 6-10%, 4 = 11-20%, 5 = 21-50%, 6 = 51=100%
NAflag(crop_agroforestry) <- 0

#writing this
#getting tile sizes
nrow(crop_agroforestry)/32
ncol(crop_agroforestry)/26
#saving a bunch of tiles
makeTiles(crop_agroforestry, y = c(14375,25000), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/crop_agroforestry/tile_.tif",
          na.rm = TRUE, extend = TRUE)

files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/crop_agroforestry/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_crop")

#testing that everything looks fine
crop_ag <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_crop")

