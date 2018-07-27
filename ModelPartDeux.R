library(sf)
library(raster)

data<-read.csv('/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/CensusCanopyDataForModelling.csv')

str(data)

PopCan.fit <- lm(data$Pcanopy ~ data$PopDensity)
PopCan.fit
summary(PopCan.fit)
plot(data$Pcanopy,data$PopDensity)
par(mfcol=c(2,2))
plot(PopCan.fit)
