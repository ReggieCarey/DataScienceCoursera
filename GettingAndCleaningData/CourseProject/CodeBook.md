# Coursera
## Data Science Specialization
### Getting and Cleaning Data
#### Course Project
##### Reginald B. Carey

Date : February 16, 2015

###### Code Book ######
This code book desribes the variables, the data, and any transformations or work performed to get and
clean the target dataset.  Note: variables listed may not exist at the end of the execution of the
main script.  The script will remove unneeded variables from the environment. When examining each
subscript, this below variables block will be handy in understanding variable use.  The position in 
the section will identify where the variable is first introduced.

**Variables**

downloadData.R

- url - character vector - provided as part of the project instructions
- filename - character vector - the name of the file where the contents of the url are placed
- dataLoadedtime - character vector - the date and time that the url was downloaded

loadData.R

- activity_labels - data.frame - the loaded contents of the activity_labels.txt file. Provides a 
mapping between the numeric values used in the data and a human readable text for the activity described by the features in that current row of the dataset.
- feature_labels - data.frame - the loaded contents of the feature_lables.txt file. Provides a 
mapping between the feature indices and a human readable text for that particular feature.  Used to
label the columns of the dataset.
- subject_train - data.frame - the loaded contents of the subject_train.txt file. Provides indication
of which subject provided a particular row of the dataset. This dataset is used for training.
- X_train - data.frame - the loaded contents of the X_train.txt file. Provides the set of features
captured for each subject.  Columns contain the individual features, rows contain the data samples.
This dataset is used for training.
- y_train - data.frame - the loaded contents of the y_train.txt file. Provides the code indicating the
particular activity the subject was performing to create the set of features for a particular data
sample. This dataset is used for training.
- subject_test - data.frame - the loaded contents of the subject_test.txt file. Provides indication
of which subject provided a particular row of the dataset. This dataset is used for testing.
- X_test - data.frame - the loaded contents of the X_test.txt file. Provides the set of features
captured for each subject.  Columns contain the individual features, rows contain the data samples.
This dataset is used for testing.
- y_test - data.frame - the loaded contents of the y_test.txt file. Provides the code indicating the
particular activity the subject was performing to create the set of features for a particular data
sample. This dataset is used for testing.

run_analysis.R

- subj - data.frame - combined test and training subject data.frames
- X - data.frame - combined test and training X data.frames
- y - data.frame - combined test and training y data.frames
- mean_features - data.frame - subset of the feature_labels containing only labels representing 
features containing means
- std_features - data.frame - subset of the feature_labels containing only labels representing 
features containing standard deviations
- combined_features - data.frame - combined mean_features and std_features.
- combined - data.frame - A subset of the X data.frame containing only combined_features
- subject - factor - The factored subj content. Used to identify source of each row of data
- activity - factor - The factored activity labels content. Used to identify the activity described
by each set of features.
- dataset - data.frame - The data set containing the activity label, subject and feature vector 
for each sampled data point.
- tmp - data.frame - temporary variable use to hold aggregated data.  Contains two extra columns that
need to be removed to produce the final tidy data set.
- tidydataset - data.frame - the data set produced by aggregating dataset by activity and subject
computing the means of each feature.

**Transformations and Work Performed**

The primary transformations of the original data occur in the run_analysis.R file. 

subj, X, y are the result of doing an rbind() operation on test and training data.  The purpose 
of which is to recombine the split up data into a single set of R objects.

mean_features, std_features are the result of subsetting the feature_labels data.frame.  A regular
expression is used to determine which feature_labels fit in either mean_features or std_features.

combined_features is the rbind() of the mean and std features.

We utilize the column indices in the combined_features data.frame to subset the columns in the X 
data frame.  We then utilize the column text in the combined_features to set the column names of 
the subsetted data.

combined is the resulting data frame due to subsetting by the columns in combined_features.

subject is the result of computing factors for subj

activity is the result of computing factors for activity_labels and then applying them to each 
member of the y data frame. This results in a vector of human readable activities.

dataset is the result of doing a cbind() over the activity, subject and combined data frames.

tmp is the result aggregating dataset by activity and subject and computing the means of each column

tidydataset is the result of subsetting tmp removing the 3rd and 4th column - they are redundant
left overs from the aggregation step.
