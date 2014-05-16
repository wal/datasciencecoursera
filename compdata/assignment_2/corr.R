source('getmonitor.R')
corr <- function(directory, threshold = 0) {

  data <- complete(directory)  
  
  cor_monitor <- function(row) {    
    monitor_data <- getmonitor(row['id'], directory)    
    cor(monitor_data$sulfate, monitor_data$nitrate,use = "pairwise.complete.obs")            
  }
  
  data_above_threshold <- data[data$nobs > threshold,]
 
  if(nrow(data_above_threshold) > 0) {
    apply(data_above_threshold, 1, cor_monitor)
  } else {
    c()
  }
}