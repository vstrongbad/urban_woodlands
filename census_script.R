#
# Script extracts census info based on input list of counties (st and county fips) and census variable names
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
counties<-fread("/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/MergedCounties.csv") %>%
          select(STATE_FIPS, CNTY_FIPS) %>%
          unique()
census_vars <- as.character(read.csv("/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/CensusVars.csv", head=F)$V1)

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

# Spread out the eav structure
tidytbl<-select(tbl, -moe) %>%
         spread(key = variable, value=estimate)

# Check that blockgroups are unique: yes
  #select(tidytbl, GEOID, NAME) %>%
  #unique() %>%
  #nrow()
  
# Write tidy results 
  write.csv(tidytbl, "/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/acs2015_blkgrps_111counties.csv")




