library(jsonlite)
library(tidyjson)
library(dplyr)
library(RJSONIO)

addDateSeq <- function(data, maxdate){
  i = 1
  dateIni <- maxdate
  while (i <= nrow(data)) {
    data$adjDate <- dateIni
    i = i +1
    dateIni = dateIni - 1
  }
}

extConvWeight <- function(json, reportdate){
  if (is.null(json)) return()
  dcmbd <- json %>% as.tbl_json %>%
    enter_object("delayedConversionsMultiplierByDay") %>%
    gather_array %>%
    append_values_string("convWeight") %>%
    mutate(reportDate = reportdate) %>%
    addDateSeq(., reportdate)
  
  return(dcmbd)
}
