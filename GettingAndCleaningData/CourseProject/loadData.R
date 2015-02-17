###############################################################################
## Student Name : Reginald Carey
## Course : Coursera - Data Science Specialization : Getting and Cleaning Data
## School : Johns Hopkins University
## Date : February 16, 2015
## Assignment : Course Project
## File : loadData.R
###############################################################################
#
# This file will start loading objects into R memory. In particular, it will
# create an activity_labels structure from a text file on disk.  activity_labels
# are the human readable activity label associated with each data item.
# feature_labels represent the names associated with each feature of collected
# data. We will use the feature labels to name the columns of the data.
# subject_train/test - the subject (one of thirty) associated with the given
# data.  There is one row per data set.
# X_train/test - the actual data points computed/collected
# y_train/test - the labels associated with each data point (see activity_labels)
# We do not bother with the raw data points collected. We rely on the processed
# data instead.
#
# activity_labels
# feature_labels
# subject_train
# subject_test
# X_train
# X_test
# y_train
# y_test
#
###############################################################################

# Load the activity labels - these labels are used to label the
# training and test data. (See y_test and y_train below)

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = TRUE)

# Load the feature labels - these are the column names for the
# training and test data. (See X_test and X_train below)

feature_labels = read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

#### LOAD THE TRAINING DATA ####

# Load the training data into tables

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset//train/y_train.txt")

# This is the raw inertial signal set - we're relying on the processed data in X_train and y_train above

#body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
#body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
#body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
#body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
#body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
#body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
#total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
#total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
#total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

#### LOAD THE TEST DATA ####

# Load the test data into tables

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset//test/y_test.txt")

# This is the raw inertial signal set - we're relying on the processed data in X_test and y_test above

#body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
#body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
#body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
#body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
#body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
#body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
#total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
#total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
#total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
