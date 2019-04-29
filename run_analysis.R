
library(dplyr)
library(plyr)
library(reshape)
library(maditr)
#Step 1- Merge the training and test dataset

dfile1 <- "./UCI HAR Dataset/train/subject_train.txt"
dfile2 <- "./UCI HAR Dataset/train/x_train.txt"
dfile3 <- "./UCI HAR Dataset/train/y_train.txt"

dfile4 <- "./UCI HAR Dataset/test/subject_test.txt"
dfile5 <- "./UCI HAR Dataset/test/x_test.txt"
dfile6 <- "./UCI HAR Dataset/test/y_test.txt"

dfile7 <- "./UCI HAR Dataset/features.txt"
dfile8 <- "./UCI HAR Dataset/activity_labels.txt"

subjecttrain <- read.table(dfile1)
xtrain <- read.table(dfile2)
ytrain <- read.table(dfile3)

subjecttest <- read.table(dfile4)
xtest <- read.table(dfile5)
ytest <- read.table(dfile6)

vars <- read.table(dfile7)
activitylbl <- read.table(dfile8)


subject <- rbind(subjecttest, subjecttrain)
rm(list = c('subjecttest','subjecttrain'))

x <- rbind(xtest, xtrain)
rm(list = c('xtest','xtrain'))

y <- rbind(ytest, ytrain)
rm(list = c('ytest','ytrain'))

#Join Activity label to y

y <- join(y, activitylbl, by ="V1")
#head(y)

#Changing the names of attributes

names(subject) <- c("subjectid")
names(y) <- c("activitynum", "activity")

vars$V2 <-gsub("-","",vars$V2)
vars$V2 <-gsub(",","",vars$V2)
vars$V2 <-gsub("\\(","",vars$V2)
vars$V2 <-gsub("\\)","",vars$V2)
vars$V2 <- tolower(vars$V2)

names(x) <- c(vars$V2)


varsfilter <- filter(vars, grepl("mean|std", vars$V2))
varsvector <- c(varsfilter$V2)

xfilter <- x[,c(varsvector)]

result <- cbind(subject, y, xfilter)
result <- select(result, -c("activitynum"))


result <- melt(result, id=c("subjectid","activity"))
result <- dcast(result, subjectid+activity ~ variable, mean)
head(result[,1:10],3)
