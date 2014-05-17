options(warn=-1)

# Part 1 - Histogram of heart attack mortality rate
data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
str(data)
data[,11] <- as.numeric(data[,11])
hist(data[,11])

# Part 2 - best hospital in a state
source('best.R')
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

# Part 3 - Rank hospital in a state
source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
## [1] "DETAR HOSPITAL NAVARRO"
rankhospital("MD", "heart attack", "worst")
## [1] "HARFORD MEMORIAL HOSPITAL"
rankhospital("MN", "heart attack", 5000)
## [1] NA
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "pneumonia", 1000)


