library(plyr)
library(reshape2)

data_file <- "data.zip"

# Download data file once
if (!file.exists(data_file)){
  download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", data_file, method="curl")
  unzip(data_file) 
}  

data_dir  <- "UCI\ HAR\ Dataset"
test_dir  <- paste(data_dir, "test", sep="/")
train_dir <- paste(data_dir, "train", sep="/")

subject_test_data <- read.table(paste(test_dir, "subject_test.txt", sep="/"), sep="\n", strip.white=T)

test_x_data  <- read.table(paste(test_dir, "X_test.txt", sep="/"), sep="\n", strip.white=T)
test_y_data  <- read.table(paste(test_dir, "y_test.txt", sep="/"), sep="\n", strip.white=T)

test_x_data  <- ldply(strsplit(gsub(" {2,}", " ", test_x_data$V1), " "))

test  <- cbind(test_x_data, test_y_data, subject_test_data)


subject_train_data <- read.table(paste(train_dir, "subject_train.txt", sep="/"), sep="\n", strip.white=T)
train_x_data <- ldply(strsplit(gsub(" {2,}", " ", train_x_data$V1), " "))



train_x_data <- read.table(paste(train_dir, "X_train.txt", sep="/"), sep="\n", strip.white=T)
train_y_data <- read.table(paste(train_dir, "y_train.txt", sep="/"), sep="\n", strip.white=T)

train <- cbind(train_y_data, subject_train_data, train_x_data)


# Merge training and test sets
combined <- rbind(train, test)


feature_names <- read.table(paste(data_dir, "features.txt", sep="/"), sep="\n", strip.white=T)
feature_names <- gsub("^[0-9]+ ", "", feature_names$V1)


mean_std_measures <- grepl("mean|std", feature_names)
combined <- combined[,c(TRUE, TRUE, mean_std_measures)]

column_headers <- c("activity", "subject", feature_names[mean_std_measures])
rm(feature_names, mean_std_measures)
colnames(combined) <- column_headers

for (i in 3:ncol(combined)){
  combined[,i] <- as.numeric(combined[,i])
}

write.table(combined, file="combined_data_set.txt")

means <- aggregate( combined[,3] ~ combined$subject + combined$activity, data = combined, FUN = mean )

for (i in 4:ncol(combined)){
  means[,i] <- aggregate( combined[,i] ~ combined$subject + combined$activity, data = combined, FUN = mean )[,3]
}

colnames(means) <- column_headers

write.table(means, file="average_by_activity_and_subject.txt")



   
