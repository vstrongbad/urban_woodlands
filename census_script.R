library(raster)
library(gfcanalysis)

test <-raster('/nfs/mshelley-data/hansen test.tif')


library(acs)
library(dplyr)

acs <- GET("api.census.gov/data/2016/acs/acs1/profile?get=DP02_0001PE&for=state:*?&key=8de74022e3813cdf1da76a6230a84d076bdf4ebe")
my_key <-  "" #put your key in between quotes
  
# Load acs library
# Complete docs at https://cran.r-project.org/web/packages/acs/acs.pdf
md.blkgrp = geo.make(block.group="*", tract="*", county="*", state="MD")
b03002 <- acs.fetch(geography=md.blkgrp, table.number="B03002", endyear='2015', span=5, key=my_key)




# First, create a geography
# For example, all counties in Texas
tx.counties = geo.make(county="*", state='TX')
# Or all tracts in Dallas and Tarrant county, using fips code
tx.tracts = geo.make(tract='*', county=c(113, 439), state='TX')

# Get a table by its code with the geography you just made
b03002 <- acs.fetch(geography=tx.counties, table.number="B03002", endyear='2015', span=5)

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

