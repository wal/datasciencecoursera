OUTCOMES <- c("heart attack", "heart failure","pneumonia")
OUTCOME_DATA_COLUMNS <- c(11, 17, 23)

rankhospital <- function(state, outcome, num = "best") {
    
    ## Read outcome data
    data <- read.csv("data/outcome-of-care-measures.csv", colClasses="character")

    ## Check that state and outcome are valid
    if (!state %in% data$State) {
        stop("invalid state")
    }

    if(!outcome %in% OUTCOMES) {
        stop("invalid outcome")
    }

    ## Return hospital name in that state with the given rank
    state_data <- subset(data, State == state)
    outcome_column_index <- OUTCOME_DATA_COLUMNS[which(OUTCOMES == outcome)]

    outcome_data <- state_data[,c(2,outcome_column_index)]
    outcome_data[,2] <- as.numeric(outcome_data[,2])
    
    outcome_data.sorted <- outcome_data[order(outcome_data[,2], outcome_data[,1]),]
    outcome_data.sorted.complete <- outcome_data.sorted[complete.cases(outcome_data.sorted),]
    
    outcome_data.sorted.complete$Rank <- rank(outcome_data.sorted.complete[,2], ties.method='first')

    
    
    if(num == "best") {
        num = 1
    } else if (num == "worst") {
        num = nrow(outcome_data.sorted.complete)
    } else {
        if(!is.numeric(num)) {
          num = 1
      }
    }

    if (num > nrow(outcome_data.sorted.complete)) {
        return NA
    } else {
        return outcome_data.sorted[which(outcome_data.sorted.complete$Rank == num),1]
    }    
}
