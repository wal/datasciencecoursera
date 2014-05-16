complete <- function(directory, id = 1:332) {
    nobs <- numeric(0);

    for(sensor in id) {
        padded_sensor_id <- str_pad(sensor, 3, "left", "0")
        sensor_data_file_path <- paste(directory, "/", padded_sensor_id, ".csv", sep="")
        sensor_data <- read.csv(sensor_data_file_path)
        nobs <- c(nobs, sum(complete.cases(sensor_data)))
    }

    data.frame(id=id, nobs=nobs)
}      
