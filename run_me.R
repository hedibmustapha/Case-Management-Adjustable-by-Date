if(!("rstudioapi" %in% installed.packages()[,"Package"])){install.packages("rstudioapi")};require("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


source("./internal/run_master.R")

########################
########################
# PARAMETERS
########################
########################

parameters<-list()


# meta
#######################

# name your project
parameters$name<- "test" 

# WHERE IS THE DATA, AND WHAT ARE THE NAMES OF THE RELEVANT headers?
parameters$data_file<-"./input/data.csv"
parameters$name_headers<-"./input/headers.csv"

# SET the start and end date.
########################

parameters$start_date <- "2018-06-01"
parameters$end_date <-"2018-12-31"

########################      
# WHAT ANALYSIS NEEDED?
########################        


# global aggregates?
parameters$do_global_counts<-T


# local aggregates?

parameters$do_disaggregated_counts<- T
parameters$do_disaggregated_percent<-F
parameters$disaggregate_by<-"camp_name"


########################
########################
# let's go!
########################
#######################

run(parameters)
