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
library(data.table)

# Put your key in the quotes and run so it doesn't have to be specified wiht each api call
census_api_key("", install=T)

# Import tables of desired variables and counties
counties<-fread("MergedCounties.csv") %>%
          select(STATE_FIPS, CNTY_FIPS)

census_tables<-fread("CensusTables.csv", head=F)

# Here is the format for requesting block group data from a year in the acs by county
#x<-get_acs(geography='block group', table='B03002', year=2016, state=36, county=27)

tbl <- data.frame()

for (t in 1:2) {
  tabn = census_tables[t,1]
  
  for (c in 1:2) {
    st=counties[c,1]
    co=counties[c,2]
    x<-get_acs(geography='block group', table=tabn, year=2016, state=st, county=co)
    tbl<-rbind(tbl,x)
    c+1
  }
  t+1
}
  



