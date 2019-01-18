# Introduction

`Case-Management-Adjustable-by-Date` is a small R project designed for use with case management beneficiary datasets. Specifically it is designed to automate the analysis for the most commonly requested figures in a specified period of time (adjustable).

`Case-Management-Adjustable-by-Date` is built to help user deal with date format data and do quick monitoring and simple analysis.

`Case-Management-Adjustable-by-Date` project allows to:

- calculate number of beneficiaries reached with services (by service type) in  specified period of time

- calculate number of new beneficiaries reached with services (by service type) in  specified period of time

- calculate number of visits/sessions (by service type) in  specified period of time

**For each of the above four indicators, it is possible to disaggregate by any other variable of your choosing in your dataset (age group, gender, location, etc.).**

# Case-Management-Adjustable-by-Date walk through

## Prerequisite

To be able to use `Case-Management-Adjustable-by-Date` you will need:

- R: download here: (https://cran.rstudio.com/). 

- R Studio (https://www.rstudio.com/products/rstudio/download/#download)
## Folders

Input: put your dataset in csv format and your variables definitions.

Internal: source code 

Output: results in csv format.

## Quick start
#### data sample

| collect_team_name  | beneficiary_ID | camp_name | nurse_assessement_date|nurse_followup_1|nurse_followup_2|nurse_followup_3|protection_assessement_date|protection_followup_1|protection_followup_2
| ------------- | ------------- |------------- |------------- |------------- |------------- |------------- |------------- |------------- |------------- |
| Alpha  | 1  |camp1|16/09/2018|20/09/2018| | | 06/06/2018| | | 03/10/2018
| fox  | 2  | camp2 |15/09/2018| 21/09/2018 | 15/07/2018 | | | 02/10/2018 | 11/10/2018
| Alpha  | 3  |camp1|18/09/2018|24/09/2018| | | 08/06/2018| | | 05/10/2018
| fox  | 4 | camp3 |16/09/2018| 26/09/2018 | 20/07/2018 | | | 08/10/2018 | 14/10/2018

Now let's say we want to calculate the overall number of beneficiaries that received visits for nurse and protections services between **16/09/2018** and **05/10/2018** and then disaggregate by camp name (numbers and percenates). Also we want to know the total numbers of visits for the same period of time.

#### run_me.R
```
parameters$start_date <- "2018-09-16"
parameters$end_date <-"2018-10-05"
```
**Global aggregate**
```
parameters$do_global_counts<-TRUE
```
**local aggregate**
```
parameters$do_global_counts<-TRUE
parameters$do_disaggregated_percent<-TRUE
parameters$disaggregate_by<-"camp_name"
```
After initializing all the parameters source the script, wait until the end of the execution. The results are in the output folder.

## R packages used
- lubridate
- rstudioapi

## Contact
**hedi.benmustapha@msb.tn**

