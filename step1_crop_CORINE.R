library(terra)
CORINE <- rast("C:/Users/am1355/OneDrive - University of Leicester/misc/corine_2018/u2018_clc2018_v2020_20u1_raster100m/u2018_clc2018_v2020_20u1_raster100m/DATA/U2018_CLC2018_V2020_20u1.tif")
TCD <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD10m")
TCD100m <- rast("C:/Users/am1355/OneDrive - University of Leicester/euraf stuff/TCD_2018_100m_eu_03035_v020/DATA/TCD_2018_100m_eu_03035_V2_0.tif")

CORINE <- resample(CORINE, TCD)

CORINE_crop <- classify(CORINE,
                           rcl = matrix(c(0, 11, 0,
                                          11, 14, 1,
                                          14, 18, 0,
                                          18, 22, 1,
                                          22, 256, 0), 
                                        ncol = 3, byrow=TRUE
                           ), include.lowest = FALSE)

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
crop_agroforestry <- CORINE_crop + (CORINE_crop*TCD)
NAflag(crop_agroforestry) <- 0

nrow(crop_agroforestry)/32
ncol(crop_agroforestry)/26

makeTiles(crop_agroforestry, y = c(14375,25000), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_crop/tile_.tif",
          na.rm = TRUE, extend = TRUE)
files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_crop/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_crop_CORINE")


#now doing this for the 100m to offer a comparison
CORINE <- resample(CORINE, TCD100m)

CORINE_crop <- classify(CORINE,
                        rcl = matrix(c(0, 11, 0,
                                       11, 14, 1,
                                       14, 18, 0,
                                       18, 22, 1,
                                       22, 256, 0), 
                                     ncol = 3, byrow=TRUE
                        ), include.lowest = FALSE)

TCD100m <- classify(TCD100m, rcl = matrix(c(0, 0, 0,
                                    1, 5, 1,
                                    5, 10, 2,
                                    10, 20, 3,
                                    20, 50, 4,
                                    50, 100, 5,
                                    254, 256, 0), 
                                  ncol = 3, byrow=TRUE
))
#raster calculator on the final product
crop_agroforestry <- CORINE_crop + (CORINE_crop*TCD100m)
NAflag(crop_agroforestry) <- 0
nrow(crop_agroforestry)/50
ncol(crop_agroforestry)/50
makeTiles(crop_agroforestry, y = c(920, 1300), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_crop_100m/tile_.tif",
          na.rm = TRUE, extend = TRUE)
files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_crop_100m/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_crop_CORINE_100m")
