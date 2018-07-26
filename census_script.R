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

# Import tables of desired variables and counties
counties<-fread("MergedCounties.csv") %>%
          select(STATE_FIPS, CNTY_FIPS)

census_tables<-fread("CensusTables.csv", head=F)

# Get list of vars in 2015 5 yr ACS
vars<-load_variables(2015,"acs5/profile")


# Here is the format for requesting block group data from a year in the acs by county
#x<-get_acs(geography='block group', variable='', year=2016, state=36, county=27)

# Create blank data frame for holding api returns
tbl <- data.frame()

# Loop through the list of tables
for (t in 1:nrow(census_tables)) {
  tabn = census_tables[t,1]
  
  # For each table, loop through all the counties to return blockgroup-level info and rbind to tbl
  for (c in 1:nrow(census_tables)) {
    st=counties[c,1]
    co=counties[c,2]
    x<-get_acs(geography='block group', table=tabn, year=2015, state=st, county=co)
    tbl<-rbind(tbl,x)
    c+1
  }
  t+1
}
  
# Write tbl results 
#write.csv(tbl, "/nfs/urbanwoodlands-data/")

# Spread out the eav structure
tidytbl<-spread(tbl, key = variable, value=estimate)



