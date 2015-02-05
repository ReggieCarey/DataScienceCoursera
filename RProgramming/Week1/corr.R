#######################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Specialization : R Programming
## School : Johns Hopkins University
## Date : January 17, 2014
## Assignment : #1
#######################################################################

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  result = numeric(332)
  idx = 0
  for (i in 1:332) {
    filename = sprintf("%003d.csv", i)
    data <- read.csv(paste(sep="/", directory, filename))
    complete = data[complete.cases(data),]
    if (nrow(complete) > threshold) {
      nitrate <- complete[["nitrate"]]
      sulfate <- complete[["sulfate"]]
      idx <- idx + 1
      result[idx] <- cor(nitrate,sulfate)
    }
  }
  length(result) <- idx
  result
}
