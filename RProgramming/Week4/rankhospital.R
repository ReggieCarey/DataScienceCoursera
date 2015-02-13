#######################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Specialization : R Programming
## School : Johns Hopkins University
## Date : January 25, 2014
## Assignment : #3
#######################################################################

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  
  data  <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  
  if (!state %in% data$State) {
    stop("invalid state")
  }
  ds1 <- data[state == data$State,]
  
  n = colnames(ds1)
  strlen = nchar("Hospital.30.Day.Death..Mortality..Rates.from.") + 1
  outcomes = grep("^Hospital.30.Day.Death..Mortality..Rates.from.", n)
  x <- outcomes[grep(paste("^",gsub(" ",".",outcome), "$",sep=""), substring(n[outcomes],strlen), ignore.case=TRUE)]
  if (length(x) == 0) {
    stop("invalid outcome")
  }
  ds2 <- ds1["Not Available" != ds1[x],]

  ## Return hospital name in that state with the given rank
  ## 30-day death rate

  if (is.character(num) && num == "best") {
    num = 1
  }
  if (is.character(num) && num == "worst") {
    num = nrow(ds2)
  }
  if (is.character(num)) {
    num = as.numeric(num)
  }
  ds2[order(as.numeric(ds2[[x]]),ds2$Hospital.Name),]$Hospital.Name[num]
}