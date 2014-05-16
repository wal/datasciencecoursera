setwd("~/projects/wal/r-learning/coursera/stats1/week3/")
data <- read.table("Stats1.13.HW.03.txt", header=T)

str(data)
head(data)

# Q1
round(cor(data$S1.pre, data$S2.pre), 2)

# Q2
round(cor(data$V1.pre, data$V2.pre), 2)


# Q3
data$S.pre <- (data$S1.pre + data$S2.pre)/2
data$V.pre <- (data$V1.pre + data$V2.pre)/2
head(data)
cor(data$S.pre, data$V.pre)

#Q4
control_group <- data[data$cond == 'des',]
cor(control_group[3:10])

# Q5
data$S.pre <- (data$S1.pre + data$S2.pre)/2
data$S.post <- (data$S1.post + data$S2.post)/2
data$S.improved <- data$S.post - data$S.pre
cor(data$S.pre, data$S.improved)

# Q6
data$V.pre <- (data$V1.pre + data$V2.pre)/2
data$V.post <- (data$V1.post + data$V2.post)/2
data$V.improved <- data$V.post - data$V.pre
cor(data$V.pre, data$V.improved)

# Q7
des_group <- data[data$cond == 'aer',]
des_group$S.pre <- (des_group$S1.pre + des_group$S2.pre)/2
des_group$S.post <- (des_group$S1.post + des_group$S2.post)/2
des_group$S.improved <- des_group$S.post - des_group$S.pre
mean(des_group$S.improved)


library(gclus) 
pre.r = abs(cor(cbind(data[3], data[4], data[7], data[8])))
pairs(pre.r, order.single(pre.r), panel.colors = dmat.color(pre.r), gap=.5)