#this code extracts downloaded Copernicus files and unzips them
#changeoutdir and files to match your computer
#assumes downloads are in my download folder


outDir<-"C:/Users/am1355/OneDrive - University of Leicester/Publications/EURAF_LPIS/TCD10m_raw/"
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
