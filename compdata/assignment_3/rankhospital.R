rankhospital <- function(state, outcome, num = "best") {
  care_measures_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  data <- NULL
  if(outcome == 'heart attack') {
    data <- care_measures_df[care_measures_df$State == state, c(2,7, 11)]
  } else if(outcome == 'heart failure') {    
    data <- care_measures_df[care_measures_df$State == state, c(2,7, 17)]
  } else if (outcome == 'pneumonia') {
    data <- care_measures_df[care_measures_df$State == state, c(2,7, 23)]
  } else {
    stop("invalid outcome")
  }  
  
  if (nrow(data) > 0) {    
    data[,3] <- suppressWarnings(as.numeric(data[,3])) 
    data <- data[complete.cases(data),]
  } else {
    stop("invalid state")
  }
    
  ordered_by_value <- data[order(data[,3], data[,1], decreasing=FALSE, na.last=TRUE),]
  ordered_by_value[,'Rank'] <- rank(ordered_by_value[,3])
  
  if(is.numeric(num)) {
    rank <- num
  } else if (num == "best") {
    rank <- 1
  } else if(num == "worst") {
    rank <- nrow(data)
  }
  
  ordered_by_value[rank,1]  
}