#
#library(raster)
#library(gfcanalysis)
#
#test <-raster('/nfs/mshelley-data/hansen test.tif')
#

library(devtools)
library(ggplot2)
library(dplyr)
library(tidycensus)

# Put your key in the quotes and run so it doesn't have to be specified wiht each api call
census_api_key("", install=T)

x<-get_acs(geography='block group', table='B03002', year=2016, state="MD")


