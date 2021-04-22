rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
# ---- load-sources ------------------------------------------------------------


# ---- load-packages -----------------------------------------------------------
import::from("magrittr", "%>%")
requireNamespace("readr")
requireNamespace("dplyr")
requireNamespace("checkmate")

library(sf)
library(ggplot2)
library(maps)
library(mapdata)
library(leaflet)

# ---- declare-globals ---------------------------------------------------------


# ---- load-data ---------------------------------------------------------------

map_path <- "./data-unshared/raw/Geo_Admin_SHP_Geographic/bf_geoadmin_25-03-2021/Community and Social Services Delivery Regions.shp"


alberta_geo_admin <- st_read(map_path)


canada_map <- st_as_sf(map(regions = "canada", fill = TRUE, plot = FALSE))


# ---- draw-map ----------------------------------------------------------------

alberta_ssdr_sf <- st_as_sf(alberta_geo_admin)

alberta_ssdr_sf %>% ggplot() +
  geom_sf() 


alberta_geo_admin %>% ggplot() +
  geom_sf()


canada_map %>% ggplot() + 
  geom_sf() +
  geom_sf(data = alberta_ssdr_sf) +
  coord_sf(xlim = c(-125,-100), ylim = c(45,66), expand = FALSE)


leaflet(alberta_ssdr_sf) %>% 
  addTiles() %>% 
  addPolygons()
  


# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_county) # Help write `dplyr::select()` call.


# ---- verify-values -----------------------------------------------------------
# OuhscMunge::verify_value_headstart(ds) # Run this to line to start the checkmate asserts.
checkmate::assert_integer(  ds$id                       , any.missing=F , lower=   1, upper=  32  , unique=T)

# ---- specify-columns-to-upload -----------------------------------------------
# Print colnames that `dplyr::select()`  should contain below:
#   cat(paste0("    ", colnames(ds), collapse=",\n"))


# ---- save-to-db --------------------------------------------------------------


# ---- save-to-disk ------------------------------------------------------------
