getmonitor <- function(id, directory, summarize = FALSE) {  
  fixed_width_id <- sprintf("%03d", as.numeric(id))
  file_name <- paste(fixed_width_id, ".csv", sep="")
  file_path <- paste(directory, file_name, sep="/")  
  
  data <- read.csv(file_path, header=TRUE,sep=",")
  
  if(summarize) {
    print(summary(data))
  } 
  
  data
}
