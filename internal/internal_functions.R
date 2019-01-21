#Remove Nas in a list
na.omit.list <- function(y) { return(y[!sapply(y, function(x) all(is.na(x)))]) }

# Initialization of lists

lists_init <- function(data, names) {
  small_list <- list()
  big_list <- list()
  for(i in 1:length(names)){
    vector <- as.character(names[,i])
    vector <- vector[!is.na(vector)]
    for(j in 1:length(vector)){
      small_list[[j]] <- data[, vector[j]]
    }
    small_list <- na.omit.list(small_list)
    big_list[[i]] <- small_list
    small_list <- list()
  }
  return(big_list)
}

# Create interval
set_interval <- function(start_date, end_date){
  return(interval(ymd(start_date), ymd(end_date)))
}

# Function that returns a list. Converts non date format variables to adequate date format
convert_to_date <- function(list_parameters){
  for(i in 1: length(list_parameters)){
    list_parameters[[i]] <- ymd(list_parameters[[i]])
  }
  return(list_parameters)
}


# Function that returns a list. first object of the list is to help calculate the number of beneficiaries (yes/no) and
# the second object is the number of visits
count_bnf_visits <- function(data, list_parameters, interval){
  vector1 <- c("")
  vector2 <- 0
for (i in 1:nrow(data)) {
  test <- 0
  for(j in 1:length(list_parameters)){
    test <- test + sum(list_parameters[[j]][i] %within% interval, na.rm = TRUE)
  }
  if(test > 0){
    
  vector1[i] <-c("yes")} else {vector1[i] <-c("no")}
  vector2[i]<- test
  
}
return(list(vector1,vector2))
  }

## Function that return a list. Calculates the overall number of bnf/visits/assessement visits

analyse_bnf_visit_overall <- function(list_bnf_visit){
  obj1 <- sum(list_bnf_visit[[1]]=="yes")
  obj2 <- sum(list_bnf_visit[[2]])
  return(list(obj1,obj2))
}

## Functions that return a data frame of calculations grouped by a variable

analyse_bnf_grouped_by <- function(data,list_bnf_visit, grouped.by){
  return(as.data.frame(table(list_bnf_visit[[1]][list_bnf_visit[[1]]=="yes"], data[,grouped.by][which(list_bnf_visit[[1]]=="yes")])))
}
analyse_bnf_grouped_by_percentage <- function(data,list_bnf_visit, grouped.by){
  return(as.data.frame(prop.table(table(list_bnf_visit[[1]][list_bnf_visit[[1]]=="yes"], data[,grouped.by][which(list_bnf_visit[[1]]=="yes")]))*100))
}

analyse_visit_grouped_by <- function(data,list_bnf_visit, grouped.by){
  return(aggregate(list_bnf_visit[[2]],
                   by=data.frame(data[,grouped.by]),
                   sum, na.rm = TRUE))
}
