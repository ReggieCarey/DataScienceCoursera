###############################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Science Specialization : Getting and Cleaning Data
## School : Johns Hopkins University
## Date : February 16, 2015
## Assignment : Course Project
## File : downloadData.R
###############################################################################
#
# This file will download a zipped version of data from the internet, record
# a timestamp of that download and then extract the contents of the downloaded
# zip file for later processing
#
###############################################################################

# set up initial url and filename for a dataload

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

# Pull the file from the internet

download.file(url = url, destfile = filename, method = "curl")

# Compute the current time the data was retrieved and save that as an R-Object to disk

dataLoadedTime <- date()

save(dataLoadedTime, file = "dataLoadTime")

# Unzip the data onto the disk

unzip(filename)

file.remove(filename)

rm(filename)
