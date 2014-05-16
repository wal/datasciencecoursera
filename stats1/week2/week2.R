library(psych)
library(sm)

setwd("~/projects/wal/r-learning/coursera/stats1/week2/")
data <- read.table("datafiles/Stats1.13.HW.02.txt", header=T)

describeBy(data, data$condition)
data.pre <- data[data$time=='pre',]
data.post <- data[data$time=='post',]
describeBy(data.pre, data.pre$condition)
describeBy(data.post,data.post$condition)


groups <- c('WM','PE','DS')

par(mfrow=c(3,2))
for (g in groups) {
    plot(density(data.pre[data.pre$condition == g,'SR']), main=g)
    plot(density(data.post[data.post$condition == g,'SR']), main=g)
}

par(mfrow=c(3,2))
for (g in groups) {
    print(paste('pre', g))
    print(paste("skew", skew(data.pre[data.pre$condition == g,'SR'])))
    print(paste("kurtosi", kurtosi(data.pre[data.pre$condition == g,'SR'])))

    print(paste('post', g))
    print(paste("skew", skew(data.post[data.post$condition == g,'SR'])))
    print(paste("kurtosi", kurtosi(data.post[data.post$condition == g,'SR'])))
}


for(g in groups) {
    premean <- mean(data.pre[data.pre$condition == g,'SR'])
    postmean <- mean(data.post[data.post$condition == g,'SR'])
    
    print(paste(g, postmean - premean))
}


