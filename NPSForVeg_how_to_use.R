#Working with NPSForVeg - how to use the NPS R package

library(devtools) 
install_github('NCRN/NPSForVeg') #load package
library(NPSForVeg)
library(dplyr)
library(tidyr)

##Load
MIDN <- importMIDN('/nfs/urbanwoodlands-data/Datasets/Data - Forest Composition and Condition/Data - Forest Plots/NPS_NETN_ForestHealthDB_2016/MIDN_unzipped/MIDN')
NCRN <- importNCRN('/nfs/urbanwoodlands-data/Datasets/Data - Forest Composition and Condition/Data - Forest Plots/NPS_NETN_ForestHealthDB_2016/NCRN_unzipped')
NETN <- importNETN('/nfs/urbanwoodlands-data/Datasets/Data - Forest Composition and Condition/Data - Forest Plots/NPS_NETN_ForestHealthDB_2016/NETN_unzipped')


#getPlants example
BTTrees <- getPlants(MIDN[[2]], 'trees', cycle = 3)
View(BTTrees)
getNames(MIDN[[2]])
#subsetting ("[[2]]" returns a single park -- in this case, 
#Booker T Washington National Monument; omitting subsetting returns values
#for entire network)


#SiteXSpec example
BTSiteXSpec <- SiteXSpec(MIDN[[2]], 'trees', cycle = 3)
View(BTSiteXSpec)

#ChangeMatrix example 
BTChange <- ChangeMatrix(MIDN[[2]], 'trees', years1 = 2006:2009, years2 = 2014:2017)
View(BTChange)

#dens example
densBT <- dens(MIDN[[2]], 'trees', years = 2014:2017)
View(densBT)
#calculates mean and 95% confidence values
#default values are counts
#could also use 'size' (basal area per plot (default), 
        #area =ha or =ac would return values per hectare or acre)
#or 'presab' (presence-absence matrix for a given plot, 1 = present)
BasalBT <- dens(MIDN[[2]], 'trees', years = 2014:2017, values = 'size')
View(BasalBT)


#IV (importance value) example
IVBT <- IV(MIDN[[2]], 'trees', years=2014:2017)
View(IVBT)

#IVplot example
IVBTPlot <- IVplot(MIDN[[2]], 
                   IVargs = list('trees', years = 2014:2017))
#IVargs can use any argument valid for IV (e.g., group or years)
     #otherwise defaults to NA
IVBTPlot #I probably didn't need to assign this then call it, but here we are
IVplot(MIDN[[2]], 
       IVargs = list('trees', years = 2014:2017),
       parts = TRUE)
#parts (defaults to FALSE) illustrates the relative contributions of components

#densplot example
densplot(MIDN[[2]], densargs = list('trees', years = 2014:2017))
#plots mean and 95% CI for given vegetation
#that is way too much to look at
densplot(MIDN[[2]], densargs = list('trees', years = 2014:2017),
         top = 6)
#to omit total for all species from plot, use Total = FALSE
densplot(MIDN[[2]], densargs = list('trees', years = 2014:2017),
         top = 6,
         Total = FALSE)

#mapPlants example
mapPlants(MIDN[2], plots = getPlotNames(MIDN[2]), 
          values = 1,
          colortype = 'numeric')
