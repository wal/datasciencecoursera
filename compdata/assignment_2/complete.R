complete <- function(directory, id = 1:332) { 
  mydata = data.frame() 
  
  for(item in id) { 
    file <- sprintf("%s/%03d.csv", directory, item) 
    data <- read.csv(file)
    rows <- sum(as.numeric(complete.cases(data))) 
    mydata <- rbind(mydata, c(item, rows))
                                                                                      
  } 
  
  names(mydata) <- c("id", "nobs") 
  
  mydata
}
