## Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
## outcome name.
## The function reads the outcome-of-care-measures.csv file and returns a character vector
## with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specifed outcome
## in that state.
## The hospital name is the name provided in the Hospital.Name variable. The outcomes can
## be one of \heart attack", \heart failure", or \pneumonia".
## Hospitals that do not have data on a particular outcome should be excluded from the set of hospitals when deciding the rankings.

## Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
## be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals \b", \c",
## and \f" are tied for best, then hospital \b" should be returned).


OUTCOMES <- c("heart attack", "heart failure","pneumonia")
OUTCOME_DATA_COLUMNS <- c(11, 17, 23)


best <- function(state, outcome) {
## Read outcome data
    data <- read.csv("data/outcome-of-care-measures.csv", colClasses="character")

    ## Check that state and outcome are valid
    if (!state %in% data$State) {
        stop("invalid state")
    }

    if(!outcome %in% OUTCOMES) {
        stop("invalid outcome")
    }

    ## Return hospital name in that state with lowest 30-day death rate
    state_data <- subset(data, State == state)

    data_column_index <- OUTCOME_DATA_COLUMNS[which(OUTCOMES == outcome)]

    # Fix data to be numeric
    state_data[,data_column_index] <- as.numeric(state_data[,data_column_index])

    # Find hospitals with lowest data
    hospitals <- which.min(state_data[,data_column_index])

    # Return the alphabetically first
    sort(state_data[hospitals, 'Hospital.Name'])[1]
}
