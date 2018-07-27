library(data.table)
library(dplyr)
library(summarytools)

fcanopy<-"/nfs/urbanwoodlands-data/Datasets/Data - Changing Urban Land Use and Land Cover/BlockGroupNLCDCanopy.csv"
facs<-"/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/acs2015_blkgrps_111counties.csv"

canopy<-fread(fcanopy) %>%
        dplyr::rename(GEOID = "FIPS,C,12") %>%
        dplyr::rename(OBJ_ID = "OBJECTID,N,10,0")

acs<-fread(facs)

x <- canopy %>%
      inner_join(acs, by="GEOID")

canopy_missing<-filter(x,is.na(OBJ_ID))
acs_missing<-filter(x,is.na(V1))
str(x)    

plot(x$Pcanopy,x$B19013_001)
plot(x$Pcanopy, x$B01003_001)

View(dfSummary(x))
help(summarytools)