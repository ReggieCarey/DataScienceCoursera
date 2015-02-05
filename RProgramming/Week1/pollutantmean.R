#######################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Specialization : R Programming
## School : Johns Hopkins University
## Date : January 17, 2014
## Assignment : #1
#######################################################################

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  approach = 1
  if (approach == 0) {
    # SLOW
    sensor = data.frame()
    for (i in id) {
      sensor <- rbind(sensor,read.csv(paste(sep="/",directory,sprintf("%003d.csv", i))))
    }
    mean(sensor[!is.na(sensor[[pollutant]]),pollutant])
  } else {
    # FASTER
    sum = 0
    rows = 0
    for (i in id) {
      data <- read.csv(paste(sep="/", directory, sprintf("%003d.csv", i)))
      set <- data[!is.na(data[[pollutant]]), pollutant]
      rows <- rows + length(set)
      sum <- sum + sum(set)
    }
    sum/rows
  }
}