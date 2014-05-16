library(stringr)

pollutantmean <- function(directory, pollutant, id = 1:332) {

    values <- numeric(0)
    
    for(sensor in id) {
        padded_sensor_id <- str_pad(sensor, 3, "left", "0")
        sensor_data_file_path <- paste(directory, "/", padded_sensor_id, ".csv", sep="")
        sensor_data <- read.csv(sensor_data_file_path)
        
        values <- c(values, sensor_data[,pollutant])
    }
    
    mean(values, na.rm=TRUE)
}
