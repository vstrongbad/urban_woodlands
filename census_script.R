
# library(raster)
# library(gfcanalysis)
# 
# test <-raster('/nfs/mshelley-data/hansen test.tif')


library(acs)
library(dplyr)

my_key <-  "" #put your key in between quotes
  
# Load acs library
# Complete docs at https://cran.r-project.org/web/packages/acs/acs.pdf
md.blkgrp = geo.make(block.group="*", tract="*", county="*", state="MD")
md.county = geo.make(county="*", state="MD")
md.tract = geo.make(tract="*", county="*", state="MD")

b19013 <- acs.fetch(geography=md.blkgrp, table.number="B19013", endyear='2011',  key=my_key)
b19013 <- acs.fetch(geography=md.county, table.number="B19013", endyear='2011',  key=my_key)
b19013 <- acs.fetch(geography=md.tract, table.number="B19013", endyear='2011',  key=my_key)

#TO DO: try getting tracts for counties only in census area

# See the structure
str(b03002)
# Notice it's made up of several data structures. The ones we want are @geography, which includes FIPS info
str(b03002@geography)
# And @estimate that has the actual estimates from the ACS table, which is still pretty convaluted. 
str(b03002@estimate)

# So let's get those peices into a data frame we can better deal with using dplyr.
# Notice, I'm using the variable codes to combine data into new variables I want.
tx.counties.b03002 <- data.frame(cbind(data.frame(b03002@geography), data.frame(b03002@estimate))) %>%
  rowwise() %>% summarize(
    fips=paste0(state, county),
    percent_hispanic=B03002_012/B03002_001,
    percent_white=B03002_003/B03002_001,
    percent_black=B03002_004/B03002_001
  )

# Now I have a data frame I can use.
str(tx.counties.b03002)

