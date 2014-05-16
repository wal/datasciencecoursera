agecount <- function(age = NULL) {
  if(is.null(age)) {
    stop("Age cannot be null")
  }
  
  homicides <- readLines("homicides.txt")
  regex <- paste(",.*?",as.character(age),"years old</dd>")

  length(grep(regex, homicides))  
}
