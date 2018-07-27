rm(list=ls())

library(doBy)
library(ggplot2)
library(grid)
library(gridExtra)
library(reshape2)
library(RColorBrewer)
library(plotly)
library(tibble)


NPS_trees <- read_csv(file="tree_data_nps.csv")

FRAME_trees<-read.csv(file="tree_data_frame_2015.csv")

new<-tibble(site_long_names=(unique(FRAME_trees$site)), Unit_Code = c("ANDO","CHR1","CHR2","COVE","CHAM","CROI","CRON","CROW","CHRY","DORO","ECOL","FOLK","GLA1","GLA2","IRO1","IRO2","LAIR","LONS","LONT","MTCI","MTCR","MOTO","PARK","PEAE","PEAW","PENN","PHIL","RESE","RITT","SMIT","STRP","STRS","SUN1","SUN2","WALT","WEBB","WHI1","WHI2"))
