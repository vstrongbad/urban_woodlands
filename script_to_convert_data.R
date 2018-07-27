rm(list=ls())

library(doBy)
library(ggplot2)
library(grid)
library(gridExtra)
library(reshape2)
library(RColorBrewer)
library(plotly)
library(tibble)

#get some sample data and convert it from x to NPS JPS

NPS_trees <- read.csv(file="/nfs/urbanwoodlands-data/Datasets/Data - Forest Composition and Condition/Data - Forest Plots/Data to test conversion to NPS/tree_data_nps.csv")

FRAME_trees<-read.csv(file="/nfs/urbanwoodlands-data/Datasets/Data - Forest Composition and Condition/Data - Forest Plots/Data to test conversion to NPS/tree_data_frame_2015.csv")

plot_name_key<-tibble(site_long_names=(unique(FRAME_trees$site)), 
            Unit_Code = c("ANDO","CHR1","CHR2","COVE","CHAM","CROI",
            "CRON","CROW","CHRY","DORO","ECOL","FOLK","GLA1","GLA2",
            "IRO1","IRO2","LAIR","LONS","LONT","MTCI","MTCR","MOTO",
            "PARK","PEAE","PEAW","PENN","PHIL","RESE","RITT","SMIT",
            "STRP","STRS","SUN1","SUN2","WALT","WEBB","WHI1","WHI2"))
