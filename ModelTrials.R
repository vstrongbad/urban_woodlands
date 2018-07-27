library(sf)
LC<- read.csv('/nfs/urbanwoodlands-data/Datasets/Data - Changing Urban Land Use and Land Cover/BlockGroupNLCDCanopy.csv')

head(LC)

PopCan <- PCanopy ~ Pop10_SQMI
PopCan.fit <- lm(log10(LC$PCanopy.N.19.11) ~ LC$POP10_SQMI.N.19.11)
PopCan.fit
summary(PopCan.fit)
plot(LC$PCanopy.N.19.11,LC$POP10_SQMI.N.19.11)
par(mfcol=c(2,2))
plot(PopCan.fit)

ACS<-read.csv('/nfs/urbanwoodlands-data/Datasets/Data - Socioeconomic Context/Census Data/acs2015_blkgrps_111counties.csv')
str(ACS)

PopCan.fit <- lm(LC$PCanopy ~ ACS$B19013_001)
mean(LC$PCanopy)
head(LC)
str(LC)

library(dplyr)
filter(LC, is.null('PCanopy'))
length(ACS)
