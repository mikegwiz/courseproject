## run_analysis.R is a script that fulfills a requirement for the peer-graded final assignemnt in Coursera's Getting and Cleaning
## Data course. 
## This script creates two tidy datasets, assuming that the source data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
## is unzipped and in your working directory.

## The resulting datasets include: 
##
## A. a tidy dataset called result.txt that 
##      - merges the training and the test sets to create one data set
##      - extracts only the measurements on the mean and standard deviation for each measurement
##      - uses descriptive activity names to name the activities in the data set
##      - appropriately labels the data set with descriptive variable names
##
## B. a tidy dataset called avgvar.txt with the average of each variable for each activity and each subject.


## Loads the required packages for the script
library(dplyr)
library(plyr)
library(reshape)
library(maditr)

## Sets the location of the necessary source files
dfile1 <- "./UCI HAR Dataset/train/subject_train.txt"
dfile2 <- "./UCI HAR Dataset/train/x_train.txt"
dfile3 <- "./UCI HAR Dataset/train/y_train.txt"
dfile4 <- "./UCI HAR Dataset/test/subject_test.txt"
dfile5 <- "./UCI HAR Dataset/test/x_test.txt"
dfile6 <- "./UCI HAR Dataset/test/y_test.txt"
dfile7 <- "./UCI HAR Dataset/features.txt"
dfile8 <- "./UCI HAR Dataset/activity_labels.txt"


## Reads the files into memory

  # Training data
subjecttrain <- read.table(dfile1)
xtrain <- read.table(dfile2)
ytrain <- read.table(dfile3)
  # Testing data
subjecttest <- read.table(dfile4)
xtest <- read.table(dfile5)
ytest <- read.table(dfile6)
  # Variable names and activity labels
vars <- read.table(dfile7)
activitylbl <- read.table(dfile8)


## Merges the testing and training data and removes the individual data from memory
  # Subjects
subject <- rbind(subjecttest, subjecttrain)
rm(list = c('subjecttest','subjecttrain'))
  # Measurements
x <- rbind(xtest, xtrain)
rm(list = c('xtest','xtrain'))
  # Activity
y <- rbind(ytest, ytrain)
rm(list = c('ytest','ytrain'))


## Joins Activity label table to Activity Table
y <- join(y, activitylbl, by ="V1")


## Changes the names of attributes in the 3 merged data frames

  # Subject and Activity Tables
names(subject) <- c("subjectid")
names(y) <- c("activitynum", "activity")
  # Cleans the variables names before changing the Measurement column names, removing special characters and setting to lowercase
vars$V2 <-gsub("-","",vars$V2)
vars$V2 <-gsub(",","",vars$V2)
vars$V2 <-gsub("\\(","",vars$V2)
vars$V2 <-gsub("\\)","",vars$V2)
vars$V2 <- tolower(vars$V2)
  # Measurements Table - sets column names based on variable list
names(x) <- c(vars$V2)


## Extracts only the measurements on the mean and standard deviation for each measurement

  # Filters for "mean" and "std" strings
varsfilter <- filter(vars, grepl("mean|std", vars$V2))
varsvector <- c(varsfilter$V2)
  # Creates a filtered measurement dataset
xfilter <- x[,c(varsvector)]


## Merges the Subject, Activity, and Measurements table into one singe dataset called result

result <- cbind(subject, y, xfilter)
  # removes the activity number field
result <- select(result, -c("activitynum"))
  #removes remaining datasets
rm(list = c('activitylbl','subject','vars','varsfilter','x','y','xfilter'))
  # writes results to a txt file in the working directory
write.table(result, "result.txt",row.name=FALSE)
message("results.txt table written to working directory")

## Creates a tidy dataset with the average of each variable for each activity and each subject

avgvar.result <- melt(result, id=c("subjectid","activity"))
avgvar.result <- dcast(avgvar.result, subjectid+activity ~ variable, mean)
  # writes avgvar.result to a txt file
write.table(avgvar.result, "avgvar.txt",row.name=FALSE)
message("avgvar.txt table written to working directory")
