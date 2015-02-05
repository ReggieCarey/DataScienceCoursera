#######################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Specialization : R Programming
## School : Johns Hopkins University
## Date : January 17, 2014
## Assignment : #1
#######################################################################

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

  result = data.frame(id=numeric(length(id)),nobs=numeric(length(id)))
  idx = 1
  for (i in id) {
    filename = sprintf("%003d.csv", i)
    data <- read.csv(paste(sep="/", directory, filename))
    result[[idx,"id"]] <- i
    result[[idx,"nobs"]] <- nrow(data[complete.cases(data),])
    idx <- idx + 1
  }
  result
}
