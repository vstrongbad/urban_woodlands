#
#library(raster)
#library(gfcanalysis)
#
#test <-raster('/nfs/mshelley-data/hansen test.tif')
#

library(devtools)
library(ggplot2)
library(tidyr)
library(dplyr)
library(tidycensus)
library(data.table)

# Put your key in the quotes and run so it doesn't have to be specified wiht each api call
census_api_key("", install=T)

# Import tables of desired variables and counties; limit to unique counties
counties<-fread("MergedCounties.csv") %>%
          select(STATE_FIPS, CNTY_FIPS) %>%
          unique()
census_vars <- as.character(read.csv("CensusVars.csv", head=F)$V1)

# Create blank data frame for holding api returns
tbl <- data.frame()
# Loop through all the counties to return blockgroup-level info and rbind to tbl
for (c in 1:nrow(counties)) {
    st=counties[c,1]
    co=counties[c,2]
    x<-get_acs(geography='block group', variables=census_vars, year=2015, state=st, county=co)
    tbl<-rbind(tbl,x)
    c+1
  }

  
# Write tbl results 
#write.csv(tbl, "/nfs/urbanwoodlands-data/")

# Spread out the eav structure
tidytbl<-select(tbl, -moe) %>%
         spread(tbl, key = variable, value=estimate)



