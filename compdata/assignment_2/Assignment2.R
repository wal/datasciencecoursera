setwd("~/projects/wal/r-learning/coursera/compdata/assignment_2/")

# Part 1
source("getmonitor.R")
source("http://spark-public.s3.amazonaws.com/compdata/scripts/getmonitor-test.R")
getmonitor.testscript()

# Part 2
source("complete.R")
source("http://spark-public.s3.amazonaws.com/compdata/scripts/complete-test.R")
complete.testscript()

# Part 3
source("corr.R")
source("complete.R")
source("getmonitor.R")
source("http://spark-public.s3.amazonaws.com/compdata/scripts/corr-test.R")
corr.testscript

cr <- corr("specdata", 2000)
n <- length(cr)
cr <- corr("specdata", 1000)
cr <- sort(cr)