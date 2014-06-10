
download_data = function(url, file) {
    if(!file.exists(file)) {
        download.file(url, destfile=file, method="curl")
    }    
}

# Question 1
quiz1_q1_data <- 'quiz1_data_question1.csv'
download_data('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', quiz1_data)
data <- read.csv(quiz1_q1_data)
nrow(subset(data,VAL==24))


# Question 3
quiz1_q3_data <- 'quiz1_data_question3.xslx'
download_data('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', quiz1_q3_data)

library(xlsx)
data <- read.xlsx(quiz1_q3_data, sheetIndex=1, header=TRUE, rowIndex = 18:23, colIndex = 7:15)
sum(data$Zip*data$Ext,na.rm=T)


# Question 4
quiz1_q4_data <- 'quiz1_data_question4.xml'
download_data('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml', quiz1_q4_data)
library(XML)
data <- xmlTreeParse(quiz1_q4_data, useInternal=T)
length(getNodeSet(data, '//zipcode[text() = "21231"]'))


# Question 5
quiz1_q5_data <- 'quiz1_data_question5.csv'
download_data('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', quiz1_q5_data)
library(data.table)
data <- fread(quiz1_q5_data)
data$SEX <- as.numeric(data$SEX)

system.time({rowMeans(data)[data$SEX==1]; rowMeans(data)[data$SEX==2]})
system.time(mean(data$pwgtp15,by=data$SEX))
system.time(data[,mean(pwgtp15),by=SEX])
system.time(tapply(data$pwgtp15,data$SEX,mean))
system.time(sapply(split(data$pwgtp15,data$SEX),mean))
system.time({mean(data[data$SEX==1,]$pwgtp15); mean(data[data$SEX==2,]$pwgtp15)})

