library(terra)
CORINE <- rast("C:/Users/am1355/OneDrive - University of Leicester/misc/corine_2018/u2018_clc2018_v2020_20u1_raster100m/u2018_clc2018_v2020_20u1_raster100m/DATA/U2018_CLC2018_V2020_20u1.tif")
TCD <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD10m")
#TCD100m <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD100m")
TCD100m <- rast("C:/Users/am1355/OneDrive - University of Leicester/euraf stuff/TCD_2018_100m_eu_03035_v020/DATA/TCD_2018_100m_eu_03035_V2_0.tif")

CORINE <- resample(CORINE, TCD)

CORINE_pasture <- classify(CORINE,
                               rcl = matrix(c(0, 17, 0,
                                              17, 18, 1,
                                              18, 256, 0), ncol = 3, byrow=TRUE
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
grass_agroforestry <- CORINE_pasture + (CORINE_pasture*TCD)
NAflag(grass_agroforestry) <- 0

nrow(grass_agroforestry)/32
ncol(grass_agroforestry)/26

makeTiles(grass_agroforestry, y = c(14375,25000), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_pasture/tile_.tif",
          na.rm = TRUE, extend = TRUE)
files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_pasture/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_grass_CORINE")


#for 100m now
CORINE <- resample(CORINE, TCD100m)

CORINE_pasture <- classify(CORINE,
                           rcl = matrix(c(0, 17, 0,
                                          17, 18, 1,
                                          18, 256, 0), ncol = 3, byrow=TRUE
                           ))
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
grass_agroforestry <- CORINE_pasture + (CORINE_pasture*TCD100m)
NAflag(grass_agroforestry) <- 0

nrow(grass_agroforestry)/50
ncol(grass_agroforestry)/50

makeTiles(grass_agroforestry, y = c(920,1300), 
          "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_pasture_100m/tile_.tif",
          na.rm = TRUE, extend = TRUE)
files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/CORINE_ag_pasture_100m/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/agroforestry_grass_CORINE_100m")
