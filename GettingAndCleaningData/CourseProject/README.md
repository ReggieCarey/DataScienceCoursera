# Coursera
## Data Science Specialization
### Getting and Cleaning Data
#### Course Project
##### Reginald B. Carey

Date : February 16, 2015

###### ASSIGNMENT ######
*see below for description of scripts in the repo*

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 

1) Merges the training and the test sets to create one data set.
1) Extracts only the measurements on the mean and standard deviation for each measurement. 
1) Uses descriptive activity names to name the activities in the data set
1) Appropriately labels the data set with descriptive variable names. 
1) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

###### SOLUTION ######

There are three scripts in this repository.  They work together to product the final resulting
R Objects.  At the head of each script is a description of its functionality.  The main entry
point for this repo is
```
run_analysis.R
```
This script will call the other scripts in order to get work done.

run_analysis.R will conduct the 5 steps of the assigment as described above.  To start with though
it must load the data set from the internet.  It will download the zip file from the given URL and 
then expand that zip file into the project folder.  Next it will read the metadata out of the top
level extracted directory then step into the test and train folders to retrieve the processed 
data sets.  Next the script will combine the test and training data into a single set of objects.
The processing continues with down selecting only those columns in the dataset that contain either
mean computations or standard deviation computations.  Next the script will generate a data set
that contains the data points, the labels and the source data.  Finally, the script will compute the
mean of each column of data by activity and subject.  This resulting data set is considered the
tiny dataset result of the project.

```
downloadData.R
```
This file will download a zipped version of data from the internet, record
a timestamp of that download and then extract the contents of the downloaded
zip file for later processing.

```
loadData.R
```
This file will start loading objects into R memory. In particular, it will
create an `activity_labels` structure from a text file on disk. `activity_labels`
are the human readable activity label associated with each data item.
`feature_labels` represent the names associated with each feature of collected
data. We will use the feature labels to name the columns of the data.

- `subject_train/test` - the subject (one of thirty) associated with the given
data.  There is one row per data set.
- `X_train/test` - the actual data points computed/collected
- `y_train/test` - the labels associated with each data point (see `activity_labels`)

We do not bother with the raw data points collected. We rely on the processed
data instead.




