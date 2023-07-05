
# Load library
# 2 Load reticulate and rgee
library("reticulate")
library("rgee") 
library("googledrive")
library("googleCloudStorageR")
library("geojsonio")
library("readxl") # to read excel files

projectname <- 'ee-martabonato91'
my_email <- 'marta.bonato91@gmail.com'
ee_Initialize(user = my_email, drive = T, gcs = F) 

# Query an image collection on GEE
dataset <- ee$ImageCollection("projects/sat-io/open-datasets/landcover/ESRI_Global-LULC_10m")
#dataset <- ee$ImageCollection("projects/sat-io/open-datasets/landcover/ESRI_Global-LULC_10m_TS")
ee_print(dataset) # to have information on the Image Collection


# create a buffer size
size <- 1000

# Option 1: Adding points coordinates manually 
#pointsx <- c(-74.46,12,11.75)  #x = long
#pointsy <- c(-11.42,51,45.72)  #y = lat

#for (i in 1:1){
#buffer <- ee$Geometry$Point(pointsx[i], pointsy[i])$buffer(size)$bounds()
##image <- dataset$filterBounds(buffer)
#image <- dataset$filterBounds(buffer)$first()
#raster_download <- ee_as_raster(image = image, region = buffer, via = "drive")
#}


# Option 2: Upload excel with points coordinates 
points_coord_orig <- read_excel("C:/Users/bonato/Documents/yield_coords.xlsx")
points_coord <- points_coord_orig[1:10,]
pointsx = points_coord$LONG  
pointsy <- points_coord$LAT  

for(i in c(1:length(points_coord))){
  buffer <- ee$Geometry$Point(pointsx[i], pointsy[i])$buffer(size)$bounds()
  image <- dataset$filterBounds(buffer)$first()
  raster_download <- ee_as_raster(image = image, region = buffer, via = "drive")
}
  

for(i in c(1:length(points_coord))){
  buffer <- ee$Geometry$Point(points_coord$LONG[i], points_coord$LAT[i])$buffer(size)$bounds()
  image <- dataset$filterBounds(buffer)$first()
  raster_download <- ee_as_raster(image = image, region = buffer, via = "drive")
}



# Clean a Google Drive folder
#ee_clean_container(name = "rgee_backup", type = "drive")


# TODO
# check if the downloaded squares correspond to the proper image collection in GEE 
# line 26 zooms in to the area of the selected buffer, chooses the first image from the Image Collection that correspond there. Check if it is the right code to use.


