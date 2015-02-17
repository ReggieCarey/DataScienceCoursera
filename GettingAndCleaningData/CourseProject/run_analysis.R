###############################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Science Specialization : Getting and Cleaning Data
## School : Johns Hopkins University
## Date : February 16, 2015
## Assignment : Course Project
## File : run_analysis.R
###############################################################################
#
#  The goal of this script is to produce tidy data from a source data set
#  containing data collected from wearable sensors, specifically the sensors
#  in a Samsung Galaxy S Smartphone.  30 subjects were recorded doing one
#  of 6 different tasks.  The smartphone conducted the recording of various
#  on board sensors including accelerometers, and gyroscopes.  A full
#  description of the data set can be retrieved from:
#  http://archive.ics.uci.edu/ml/datasets/
#         Human+Activity+Recognition+Using+Smartphones
#
###############################################################################
#
# This script will perform 5 steps
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each
#    measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#
###############################################################################
#
# GIVEN:
#   url of data to ingest - a zip file
#
###############################################################################

#### INTEGRATE THE SET OF LIBRARIES NEEDED FOR THIS ANALYSIS ####

library(data.table)

#### DOWNLOAD AND UNZIP DATA AND RECORD TIME OF DOWNLOAD ####

source("downloadData.R")

#### LOAD DATA ####

# Produces activity_labels, feature_labels,
# subject_test/train, X_test/train, and y_test/train

source("loadData.R")

###########################################################################
####  1)  Merge the training and the test sets to create one data set  ####
###########################################################################

# bind the test and training data together

# subj - the columnar data identifying the subject associated with each
#        datapoint

subj <- rbind(subject_test, subject_train)

# cleanup global environment

rm(subject_test, subject_train)

# X - the tabular data containing a data point per row.  Each column contains
#     measured or computed features.

X <- rbind(X_test, X_train)

# cleanup global environment

rm(X_test,X_train)

# y - the columnar data identifying the activity associated with each
#     data point

y <- rbind(y_test, y_train)

# cleanup global environment

rm(y_test, y_train)

###########################################################################
####  2)  Extracts only the measurements on the mean and standard      ####
####      deviation for each measurement.                              ####
###########################################################################

# find the feature labels that correspond to mean and standard deviation
# measurements

mean_features = feature_labels[grep("t.*mean()", feature_labels$V2),]
std_features = feature_labels[grep("t.*std()", feature_labels$V2),]

# construct a new feature set with only these features included

combined_features = rbind(mean_features, std_features)

# use feature labels to label each column of the data set

setnames(X, names(X), feature_labels$V2)

# down select only those columns representing mean & standard deviation

combined <- X[,combined_features$V1]

# cleanup global environment

rm(mean_features, std_features, combined_features, feature_labels, X)

###########################################################################
####  3)  Uses descriptive activity names to name the activities in    ####
####      the data set                                                 ####
###########################################################################

# subject contains the subject associated with each datapoint

subject <- factor(subj$V1)

# activity contains descriptive activity names associated with each datapoint

activity <- factor(y$V1, labels=activity_labels$V2)

# cleanup global environment

rm(y, subj, activity_labels)

###########################################################################
####  4)  Appropriately labels the data set with descriptive variable  ####
####      names.                                                       ####
###########################################################################

dataset <- cbind(activity, subject, combined)

# cleanup global environment

rm(combined, subject, activity)

###########################################################################
####  5)  From the data set in step 4, creates a second, independent   ####
####      tidy data set with the average of each variable for each     ####
####      activity and each subject.                                   ####
###########################################################################

# do the averaging. This step produces warnings as the mean operation
# attempts to compute a mean over factors

tmp <- aggregate(dataset, by = c(dataset['activity'], dataset['subject']), mean)

# the final tidy dataset.  There should be #subjects * #activities rows

tidydataset <- subset(tmp, , c(1,2,5:44))

# cleanup global environment

rm(tmp)

###########################################################################
####                                                                   ####
#### There should be two datasets created as a result of this script   ####
####                                                                   ####
#### dataset - a subset of the test and training data (mean's/std's)   ####
####           with associated subject and activity data combined      ####
####                                                                   ####
#### tidydataset - the mean of dataset by activity and subject         ####
####                                                                   ####
#### dataLoadedTime - will contain the time that the zip file was      ####
####                  pulled from the internet.                        ####
####                                                                   ####
#### url - will contain the url where the source dataset.              ####
####                                                                   ####
###########################################################################

# write the tidydataset to disk

write.table(tidydataset, file = "tidyDataSet.txt", row.names = FALSE)

# to read this dataset use read.table("tidyDataSet.txt, header = TRUE)
