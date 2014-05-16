source("complete.R")

corr <- function(directory, threshold = 0) {
    cors <- numeric(0);
    
    sensors_above_threshold <- subset(complete(directory), nobs > threshold)$id

    for(sensor in sensors_above_threshold) {
        padded_sensor_id <- str_pad(sensor, 3, "left", "0")
        sensor_data_file_path <- paste(directory, "/", padded_sensor_id, ".csv", sep="")
        sensor_data <- read.csv(sensor_data_file_path)
        sensor_cor <- cor(sensor_data$nitrate, sensor_data$sulfate, use="complete.obs")        
        cors <- c(cors, sensor_cor)
    }

    cors
}
