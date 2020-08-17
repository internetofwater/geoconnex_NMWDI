#### Process boundary data
library(tidyverse)
library(sf)
library(utils)

# set PID root
root <- "https://geoconnex.us/nmwdi/boundaries/"

#read data in file
data_in <- read_csv("data_in/data_in.csv")



#huc8
download.file(as.character(data_in[8,2]), "data_in/huc8.zip")
unzip("data_in/huc8.zip",exdir="data_in")

huc8 <- st_read("data_in/wbdhu8_a_nm.geojson")
huc8$uri <- paste0(root,"huc8/",huc8$HUC8)
huc8 <- select(huc8,uri,HUC8,Name,LoadDate)

st_write(huc8,"nmwdi-boundaries/data_out/huc8.gpkg")

#state
download.file(as.character(data_in[2,2]), "data_in/st.zip")
unzip("data_in/st.zip",exdir="data_in")
st <- st_read("data_in/new_mexico_bnd.geojson")
st$uri <- paste0(root,"NM")
st$about <- "https://geoconnex.us/ref/states/35"
st_write(st,"nmwdi-boundaries/data_out/st.gpkg",overwrite=TRUE)


# places
download.file(as.character(data_in[3,2]), "data_in/places.zip")
unzip("data_in/places.zip",exdir="data_in")
places <- st_read("data_in/tl_2015_35_place.geojson")
places$uri <- paste0(root,"places/",places$GEOID)
st_write(places,"nmwdi-boundaries/data_out/places.gpkg")

# counties
download.file(as.character(data_in[7,2]), "data_in/county.zip")
unzip("data_in/county.zip",exdir="data_in")
county <- st_read("data_in/tl_2018_nm_county.geojson")
county$uri <- paste0(root,"county/",county$GEOID)
st_write(county,"nmwdi-boundaries/data_out/county.gpkg")


# congress
download.file(as.character(data_in[6,2]), "data_in/congress.zip")
unzip("data_in/congress.zip",exdir="data_in")
congress <- st_read("data_in/nm_congressional_dist.geojson")
congress$uri <- paste0(root,"congressional-district-2012-2020/",congress$District_N)
st_write(congress,"nmwdi-boundaries/data_out/congress.gpkg")

# st house
download.file(as.character(data_in[5,2]), "data_in/sthouse.zip")
unzip("data_in/sthouse.zip",exdir="data_in")
house <- st_read("data_in/house_boundaries.shp")
house <- st_transform(house, 4326)
#county$uri <- paste0(root,"county/",places$GEOID)
st_write(house,"nmwdi-boundaries/data_out/sthouse.gpkg")

# st senate
download.file(as.character(data_in[4,2]), "data_in/stsenate.zip")
unzip("data_in/stsenate.zip",exdir="data_in")
senate <- st_read("data_in/senate_boundaries.geojson")
#county$uri <- paste0(root,"county/",places$GEOID)
st_write(senate,"nmwdi-boundaries/data_out/senate.gpkg")


