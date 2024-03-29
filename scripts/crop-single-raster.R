library(sf)
library(raster)
library(tidyverse)

# read boundary
intermtn_west <- sf::read_sf('data/intermountain-west.gpkg')

# read raster data
nlcd_landcover <- raster::raster('data/NLCD_2016_Land_Cover_L48_20190424/NLCD_2016_Land_Cover_L48_20190424.img')

# reproject boundary
intermtn_west <- st_transform(intermtn_west, st_crs(projection(nlcd_landcover)))

image(nlcd_landcover)
plot(intermtn_west, add = T, border = 'white')

# crop raster to intermtn_west
nlcd_landcover_imw <- raster::crop(nlcd_landcover, as(intermtn_west, 'Spatial'),
                                   filename = 'data/nlcd_landcover_imw.grd',
                                   progress = 'text')

image(nlcd_landcover_imw, asp = 1)
plot(intermtn_west, add = T, border = 'white', lwd = 5)
