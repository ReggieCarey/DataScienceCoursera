#######################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Specialization : R Programming
## School : Johns Hopkins University
## Date : January 25, 2014
## Assignment : #3
#######################################################################

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data <- data[order(data$State),]
  
  ## Check that state and outcome are valid
  
  n = colnames(data)
  strlen = nchar("Hospital.30.Day.Death..Mortality..Rates.from.") + 1
  outcomes = grep("^Hospital.30.Day.Death..Mortality..Rates.from.", n)
  x <- outcomes[grep(paste("^",gsub(" ",".",outcome), "$",sep=""), substring(n[outcomes],strlen), ignore.case=TRUE)]
  if (length(x) == 0) {
    stop("invalid outcome")
  }
  
  ## For each state, find the hospital of the given rank
  
  listOfStates <- sort(unique(data$State))
  numStates <- length(listOfStates)
  results <- data.frame(hospital=character(numStates), state=character(numStates), row.names=listOfStates, stringsAsFactors = FALSE)
  
  lapply(split(data, data$State), function(ds1) {
    
    # get rid of entries where there is no data
    ds2 <- ds1["Not Available" != ds1[x],]
    
    # convert the outcome column to a number
    ds2[[x]] <- as.numeric(ds2[[x]])
    
    # order by the specified outcome column
    ds2 <- ds2[order(ds2[[x]], ds2$Hospital.Name),]
    
    # determine what rank to return based on passed in parameter
    rank <- if (is.character(num) && num == "best") {
      1
    } else if (is.character(num) && num == "worst") {
      nrow(ds2)
    } else if (is.character(num)) {
      as.numeric(num)
    } else {
      num
    }
    
    state = unique(ds1$State)
    results[[state, "hospital"]] <<- ds2$Hospital.Name[rank]
    results[[state, "state"]]    <<- state
  })
  
  results
}
