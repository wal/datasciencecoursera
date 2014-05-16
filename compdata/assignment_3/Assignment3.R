setwd("~/projects/wal/r-learning/coursera/compdata/assignment_3")
source("http://spark-public.s3.amazonaws.com/compdata/scripts/submitscript.R")
submit()
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
dim(outcome)


# Part 2
outcome.heart_attack <- as.numeric(outcome[,11])
outcome.heart_failure <- as.numeric(outcome[,17])
outcome.pneumonia <- as.numeric(outcome[,23])
par(mfrow=c(1,3))
rnge <- range(outcome.heart_attack, outcome.heart_failure, outcome.pneumonia, na.rm = T)
hist(outcome.heart_attack, xlab="30-day Death Rate", main="heart attack", xlim=rnge, prob=T)
abline(v=median(outcome.heart_attack, na.rm=T), col=3)
lines(density(outcome.heart_attack, na.rm=T))
hist(outcome.heart_failure, xlab="30-day Death Rate", main="heart failure", xlim=rnge, prob=T)
abline(v=median(outcome.heart_failure, na.rm=T), col=4)
lines(density(outcome.heart_failure, na.rm=T))
hist(outcome.pneumonia, xlab="30-day Death Rate", main="pneumonia", xlim=rnge, prob=T)
abline(v=median(outcome.pneumonia, na.rm=T), col=5)
lines(density(outcome.pneumonia, na.rm=T))

# Part 3
par(mfrow=c(1,1))
outcome[,11] <- as.numeric(outcome[,11])
count_by_state <- table(outcome$State)
included_states <- names(subset(count_by_state, count_by_state >=20))
outcome2 <- outcome[outcome$State %in% included_states,]

death <- outcome2[,11]
state <- outcome2$State
boxplot(death ~ state, ylab="30-day Death Rate", main="Heart Attack 30-day Death Rate by State")

# Part 4
hospital <- read.csv("hospital-data.csv", colClasses="character")
outcome.hospital <- merge(outcome, hospital, by="Provider.Number")

death <- as.numeric(outcome.hospital[,11])
npatient <- as.numeric(outcome.hospital[,15])
owner <- factor(outcome.hospital$Hospital.Ownership)

library(lattice)
xyplot(death ~ npatient| owner, 
       panel = function(x,y,...) {
        panel.xyplot(x,y,...)
        panel.lmline(x,y,col=2)
       },
       xlab="Number of Patients Seen", 
       ylab = "30-day Death Rate", 
       main ="Heart Attack 30-day Death Rate by Ownership")

# Part 5
source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

# Part 6
source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

