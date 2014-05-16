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


