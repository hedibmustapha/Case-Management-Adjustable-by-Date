
############################
# setup
############################
# empty wd
rm(list=ls())
# Install the lubridate package (helps dealing with dates)
if(!("lubridate" %in% installed.packages()[,"Package"])){install.packages("lubridate")};require("lubridate")
if(!("R2HTML" %in% installed.packages()[,"Package"])){install.packages("R2HTML")};require("R2HTML")

source("./internal/internal_functions.R")

run<-function(parameters){
  
  if(!parameters$do_global_counts && !parameters$do_disaggregated_counts && !parameters$do_disaggregated_percent && !parameters$do_referrals){
    message("All options are set to FALSE... Nothing much to do here :) ")}
  else{
  message('loading files...')
  # load inputs
  if(!file.exists(parameters$data_file)){
    stop(paste("data file csv file not found in path",paramters$data_file))
  }
  
  data<-read.csv(parameters$data_file)
  
  headers<-read.csv(parameters$name_headers, skip = 1, header = T, na.strings = "" )
  csv_names <- names(headers)
  bnf_visit <-data.frame()
  col_dates <- lists_init(data,headers)
  period_time<-set_interval(parameters$start_date,parameters$end_date)
  
  
  if(parameters$do_global_counts || parameters$do_disaggregated_counts || parameters$do_disaggregated_percent){
  for(i in 1:(length(headers))){
  list_input <- convert_to_date(col_dates[[i]])
  
  message(paste("running",i,"analysis..."))
  
  create_bnf_visits <- count_bnf_visits(data, list_input, period_time)
  
  if(parameters$do_global_counts){
  results_global <-analyse_bnf_visit_overall(create_bnf_visits)
  bnf_visit[1,i]<-results_global[[1]]
  bnf_visit[2,i]<-results_global[[2]]
  }
  if(parameters$do_disaggregated_counts){
  result_aggregate_bnf <- analyse_bnf_grouped_by(data,create_bnf_visits,parameters$disaggregate_by)
  colnames(result_aggregate_bnf)[3]<-"# beneficiaries"
  result_aggregate_bnf <- result_aggregate_bnf[,-1]
  result_aggregate_visits <- analyse_visit_grouped_by(data,create_bnf_visits,parameters$disaggregate_by)
  colnames(result_aggregate_visits)[1]<-"Grouped by"
  colnames(result_aggregate_visits)[2]<-"# visits"
  mergedData <- merge(result_aggregate_visits,result_aggregate_bnf, by.y=c("Var2"), by.x=c("Grouped by"))
  write.csv(mergedData, paste0("./output/",csv_names[i],"_",parameters$name,".csv"))
  }
  if(parameters$do_disaggregated_percent){
    result_aggregate_bnf_percent <- analyse_bnf_grouped_by_percentage(data,create_bnf_visits,parameters$disaggregate_by)
    colnames(result_aggregate_bnf_percent)[3]<-"% beneficiaries"
    result_aggregate_bnf_percent <- result_aggregate_bnf_percent[,-1]
    colnames(result_aggregate_bnf_percent)[1]<-"Grouped by"
    write.csv(result_aggregate_bnf_percent, paste0("./output/",csv_names[i],"_percent_",parameters$name,".csv"))
  }
  
  }
  }
  if(parameters$do_global_counts){
  names(bnf_visit)<-csv_names
  rownames(bnf_visit)<-c("# beneficiaries", "# visits")
  write.csv(bnf_visit, paste0("./output/global_numbers_",parameters$name,".csv"))
  }
    file <- "report.html"
    file = file.path(getwd(), file)
    cat("\n", file = file,
        append = FALSE)
    HTML.title(paste(parameters$name,"output"),file = file)
    HTMLhr(file = file)
    HTML.title("General Information", file = file)
    HTMLhr(file = file)
    HTML(paste("number of observations in the data is :", nrow(data)), file = file)
    HTML(paste("the time period is : from", parameters$start_date, "to ", parameters$end_date), file = file)
    if(parameters$do_global_counts){
      HTML(paste("Do global counts :", parameters$do_global_counts), file = file)
    }
    if(parameters$do_disaggregated_counts){
      HTML(paste("Local analysis  :", parameters$do_disaggregated_counts, " disaggregated by :", parameters$disaggregate_by), file = file)
    }
    if(parameters$do_global_counts){
      HTML(bnf_visit, file = file)
    }
    if(parameters$do_disaggregated_counts){
      HTML(mergedData, file = file)
    }
    if(parameters$do_disaggregated_counts){
      HTML(result_aggregate_bnf_percent, file = file)
    }
    HTMLhr(file = file)
    
    cat(paste("Report written: ",
              file, sep = ""))
  
  cat("script execution is finished see the folder output for results.\n")
  browseURL(file)
}
}