count <- function(cause = NULL) {
  
  valid_causes <- c("asphyxiation", "blunt force", "other", "shooting", "stabbing", "unknown")
  
  if(is.null(cause)) {
    stop("Cause cannot be NULL")
  } else if(!(cause %in% valid_causes)) {
    stop("invalid cause name")
  } 
  
  homicides <- readLines("homicides.txt")
  
  r <- regexec("<dd>Cause: (.*?)</dd>", homicides)
  m <- regmatches(homicides, r)
  causes <- sapply(m, function(x) tolower(x[2]))
  table(causes)[tolower(cause)]
}
