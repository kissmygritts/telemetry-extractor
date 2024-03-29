library(sf)
library(tidyverse)

# read data
eco_regions <- read_sf('data/us_eco_l3/us_eco_l3.shp')

## specify intermountain units by ecoregion l3 code
intermtn_west <- c(5, 9, 10, 11, 15, 16, 12, 80, 13, 14, 81, 79, 23,
                   20, 19, 18, 17, 41, 21)

## union
imw_shp <- eco_regions[eco_regions$US_L3CODE %in% intermtn_west, ] %>% 
  st_union() %>% st_convex_hull()

imw_shp

sf::st_write(imw_shp, 'data/intermountain-west.gpkg')

rm(list = ls())
