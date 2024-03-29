library(sf)
library(tidyverse)
library(leaflet)

# read boundary
intermtn_west <- sf::read_sf('data/intermountain-west.gpkg')

## get data...
telemetry <- read_csv('data/muld-telemetry.csv')
telemetry_sf <- st_as_sf(x = telemetry[complete.cases(telemetry[, c('long_x', 'lat_y')]), ],
                         coords = c('long_x', 'lat_y'),
                         crs = 4326)

## reproject data
telemetry_sf <- st_transform(telemetry_sf, crs = st_crs(intermtn_west))

## visualize
telemetry_sf[500:nrow(telemetry_sf), ] %>% 
  st_transform(crs = 4326) %>% 
  st_coordinates() %>% 
  st_linestring() %>% 
  leaflet() %>% 
  addTiles() %>% 
  leaflet::addPolylines()

sf::st_linestring(st_coordinates(telemetry_sf)) %>% 
  st_transform(crs = 4326) 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers()
  
telemetry_sf[500:nrow(telemetry_sf), ] %>% 
  st_transform(crs = 4326) %>% 
  st_coordinates() %>% 
  st_linestring() %>%
  st_line_sample(density = 1) %>% 
  st_coordinates()
  