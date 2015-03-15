# Classroom notes follow along code:

#install.packages("kernlab")
library(kernlab)
data(spam)

cat("Data frame of the spam dataset\n")
str(spam[, 1:5])

# Any randomness needs to be reproducable - how can we do this in matlab? rng(3435);
set.seed(3435)

# nrow(spam) = 4601

# Sample from a binomial distribution 4601 times with a probability of 0.5
#trainIndicator = rbinom(4601, size = 1, prob = 0.5)
trainIndicator = rbinom(nrow(spam), size = 1, prob = 0.5)

cat("\n")
print(table(trainIndicator))

# Now that we've got a tool (trainIndicator) to separate the data in to traing and test data,
# lets do so.

trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

## Exploratory Data Analysis

cat("\nNames\n")
print(names(trainSpam))

cat("\nTable of trainSample$type")
print(table(trainSpam$type))

quartz("Log of CapitalAve vs type")
plot(log10(1 + trainSpam$capitalAve) ~ trainSpam$type)
dev.off()

quartz("Log of first four")
plot(log10(trainSpam[, 1:4]+1))
dev.off()

hCluster = hclust(dist(t(trainSpam[, 1:57])))

quartz("Heirarchical Cluster")
plot(hCluster)
dev.off()

hClusterUpdated = hclust(dist(t(log10(trainSpam[,1:55] + 1))))

quartz("Heirarchical Cluster of log data")
plot(hClusterUpdated)
dev.off()

# Statistical prediction/modeling

# Create a generalized linear model to predict spam based on individual variables

# Get the type of email as a number - needed for the GLM (probably maps
# 0 - nonspam, 1 - spam)
trainSpam$numType = as.numeric(trainSpam$type) - 1

# Need to understand this cost function more.  What is x what is y
# what is it summing? - A count of how many times x is 1 when y is greater
# than 0.5.  i.e., when y(the predictor) predicts spam
costFunction = function(x, y) { sum(x != (y > 0.5)) }

# What does rep do?
cvError = rep(NA, 55)

# What doe the boot library provide
library(boot)

# There are 59 variables in the data set, what do 56,57,58 contain?  59 is the numType that we just generated
# This is pretty cool, we are doing a linear regression over 1 variable at a time for 55 different variables
# glm() takes the X and y (supervised learning) and produces glmFit the hypothesis assuming we doing a
# binomial (0 or 1) regression.  Another function cv.glm for cross validation of a generalized linear model,
# tells us how accurate we were against the actual data (trainSpam) vs model (glmFit), using the costFunction
# as a determiner for accuracy.  Dunno what the 2 or $delta[2] do.
for (i in 1:55) {
  # setting up for a univariate prediction model on each of the 55 variables
  lmFormula = reformulate(names(trainSpam)[i], response="numType")
  glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
  cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

# Which predictor (feature) has the minimum cross validated error?
cat("\nWhich predictor (feature) has the minimum cross validated error?\n")
print(names(trainSpam)[which.min(cvError)])

# Get a measure of uncertainty

# use the best model from the group (charDollar)
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)
# apparently glm creates a field "fitted"?

# get predictions on the test set - These are way cool - makes stuff easy!
predictionTest = predict(predictionModel, testSpam)

# I have no idea what rep is doing - I think it's assigning a value
# nospam for each value in data item in testSpam
predictedSpam = rep("nonspam", dim(testSpam)[1])

# Classify as 'spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"
# the above apparently changes the value of a test sample from nonspam to spam if
# the predictionModel$fitted is greater than 0.5

# Classification Table
cat("\nClassification Table\n")
print(table(predictedSpam, testSpam$type))

# Error Rate
cat("\nError Rate\n")
print((61+458)/(1346+458+61+449))
cat("\nFN = ")
cat("\n = sum(FN,FP) / sum(TP,TN,FP,FN)\n")
cat("\nThere are other scores precision & recall and f-score not produced\n")


# Interpret Results

# OUR EXAMPLE
# The faction of characters that are dollar signs can be used to predict if an email is Spam
# Anything with more than 6.6% dollar signs is classified as Spam
# More dollar signs always means more Spam under our prediction
# Our test set error rate was 22.4%


# Challenge Results

# challenge all steps - be critical of every step

# Synthesize/write-up results

# - Lead with the question
# - Summarize the analyses into the story
# - Dont include every analysis, include it
#  -- if it is needed for the story
#  -- if it is needed to address a challenge
# - Order analyses according to the story, rather than chronologically
# - Include "pretty" figures that contribute to the story

# Our Example:
# Lead with the question
# - Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?
# Describe the approach
# - Collected data from UCI -> created training/test sets
# - Explored relationships
# - Choose logistic model on training set by cross validation
# - Applied to test, 78% test set accuracy
# Interpret results
# - Number of dollar signs seems reasonable, e.g, "Make money with Viagra $ $ $ $!"
# Challenge results
# - 78% isn't that great
# - I could use more variables
# - Why logistic regression?

# Create Reproducible Code
# use knitr for example

#########################

# Organizing Your Data Analysis

# Data analysis files
# Data - raw data, processed data
# Figures - exploratory figures, final figures
# R code - raw/unused scripts, final scripts, R Markdown files
# Text - readme files, text of analysis/report

# for raw data, store in analysis folder
# include url, description, and date accessed - in the README
# for processed data, name file for script that generated the data
# processed data should be "tidy"

# exploratory figures - that you make during your analysis - not necessarily for final report
# they do not need to be pretty but they need to be useful (10 days later)

# final figures - small subset of exploratory figures, axes/colors, labels, etc. many panels?

# Raw scripts - may be uncommented, may have multiple versions, may include discarded analysis

# Final scripts - large comment blocks, highly descriptive - ready for someone to read.  Code that
# generates the final results

# R markdown files - include text and code and can be used to generate reproducable reports
# text and R code are integrated
# very easy to create in RStudio

# README files - not necsssary if using R markdown.
# should contain step by step instructions for analysis

# Text of the final document:
# Title, Author, Affiliations, Abstract, Description, Details, Conclusions, References, etc.

# check out "project template" from slides of video https://class.coursera.org/repdata-012/lecture/15




