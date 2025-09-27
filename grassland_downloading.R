#downloading the files
library(hdar)


#this code extracts downloaded Copernicus files and unzips them
#changeoutdir and files to match your computer
#downloading into my downloads
#getting login details
username <- "REDACTED"
password <-"REDACTED"
client <- Client$new(username, password)
client$get_token() #checking that this is successful

#downloading files
query <- '{
  "dataset_id": "EO:EEA:DAT:HRL:GRA",
  "productType": "Grassland",
  "resolution": "10m",
  "year": "2021",
  "startIndex": 1
}'

#searching data
matches <- client$search(query)
matches_list <- matches$results
matches_names <- rep(NA, 850)
for(i in 1:850) {
  matches_names[i] <- matches_list[[i]][["id"]]
} #getting the names of the files

#total of 850 files with 2GB (zipped)
#downloading the files
matches$download("//uol.le.ac.uk/root/staff/home/a/am1355/Downloads/",
                 force = FALSE,
                 prompt = FALSE,
                 selected_indexes =1:850,
                 stop_at_failure = FALSE)
#need to redownload some check which are missing
files <- list.files("//uol.le.ac.uk/root/staff/home/a/am1355/Downloads/",
                    pattern = "R00.zip")
files_included <- sub('\\.zip$', '', files)
missing <- which(!(matches_names %in% files_included))
#give a total of 99 files, which seems about right
matches$download("//uol.le.ac.uk/root/staff/home/a/am1355/Downloads/",
                 force = FALSE,
                 prompt = FALSE,
                 selected_indexes = missing,
                 stop_at_failure = FALSE)
#now we have downloaded them all!


#unzipping the files
outDir<-"C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grassland_raw/"
#getting files
files <- list.files("//uol.le.ac.uk/root/staff/home/a/am1355/Downloads/",
                    pattern = "R00.zip")
for(i in 1:length(files)) {
  tif_file <- paste(sub('\\.zip$', '', files[i]) ,
                     ".tif", sep = "")
#extracting
  unzip(zipfile = paste("//uol.le.ac.uk/root/staff/home/a/am1355/Downloads/",
                        files[i], sep = ""),
        files = tif_file, list = FALSE, overwrite = TRUE,
        exdir = outDir, unzip = "internal")
}

#vrt making script
library(terra)

files <- list.files("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grassland_raw/",
                    full.names = TRUE)

vrt(files, filename = "C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grassland")

#testing that everything looks fine
grassland <- rast("C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/grassland")

#plotting
plot(grassland)

#note a couple of the eu territories are missing in thee vrts
