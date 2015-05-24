## ======================================================== ##
## Getting and Cleaning Data Course Project: run_analysis.R ##
## ======================================================== ##

##setwd("../data")

library(reshape2)
library(dplyr)
library(plyr)
library(Hmisc)

file_xtest <- "./UCI HAR Dataset/test/X_test.txt"
file_ytest <- "./UCI HAR Dataset/test/y_test.txt"
file_subtest <- "./UCI HAR Dataset/test/subject_test.txt"
file_xtrain <- "./UCI HAR Dataset/train/X_train.txt"
file_ytrain <- "./UCI HAR Dataset/train/y_train.txt"
file_subtrain <- "./UCI HAR Dataset/train/subject_train.txt"
file_activity <- "./UCI HAR Dataset/activity_labels.txt"
file_features <- "./UCI HAR Dataset/features.txt"
xtest <- read.table(file_xtest)
xtrain <- read.table(file_xtrain)
ytest <- read.table(file_ytest)
ytrain <- read.table(file_ytrain)
subtest <- read.table(file_subtest)
subtrain <- read.table(file_subtrain)
activity <- read.table(file_activity, col.names=c("aCode","activity"))
features <- read.table(file_features, col.names=c("fCode","fLabel"), stringsAsFactors=FALSE)

## Retain number of columns in measurements data set ##
mCol <- ncol(xtest)

## Make complete test data set (add activity and subject columns to measurements) ##
tbTest <- cbind(xtest, subtest, ytest)

## Make complete train data set (add activity and subject columns to measurements) ##
tbTrain <- cbind(xtrain, subtrain, ytrain)

#######################################################
## 1. Merge training and test sets into one data set ##
#######################################################
tbData <- rbind (tbTest, tbTrain)

########################################################################################
## 2. First add variable names, it's easier for extraction of measurements afterwards ##
##    We know features.txt is ordered by first column which is equal to the rownumber ##
##    so first features label belongs to first measurements column, 2nd etc...        ##
########################################################################################
names(tbData)[1:mCol] <- features$fLabel[1:mCol]
names(tbData)[(mCol + 1):(mCol + 2)] <- c("subject", "ActivityCod")

################################################################
## 3. Extract measurements on the mean and standard deviation ##
################################################################
## a) First take a subset from features,retaining only the required labels
##    --------------------------------------------------------------------
##    -> all mean variables with pattern = mean()
featInScope <- features[grep("mean\\(\\)", features$fLabel), ]
##    -> extended with standard deviation variables with pattern = std() 
featInScope <- rbind(featInScope, features[grep("std\\(\\)", features$fLabel), ])

## b) Take a subset from the data set, selecting only the variables in scope
##    ----------------------------------------------------------------------
tbDataRes <- tbData[names(tbData) %in% c(featInScope$fLabel,"subject", "ActivityCod")]

##names(tbDataRes) <- gsub("\\(\\)", "", names(tbDataRes))
##names(tbDataRes) <- gsub("-", "_", names(tbDataRes))

###################################################################
## 4. Add descriptive activity names (merge with activity table) ##
###################################################################
tbDataRes <- merge(tbDataRes, activity, by.x="ActivityCod", by.y="aCode")
## remove the Activity Code, because we have now the descriptive names added
tbDataRes <- subset(tbDataRes, select=-c(ActivityCod))

###########################################################################################
## 5. Create a tidy data set with average of each variable for each activity and subject ##
###########################################################################################
colnam <- names(tbDataRes)
meltRes <- melt(tbDataRes, id=c("subject", "activity"), measure.vars=c(colnam[1:66]))
endRes <- dcast(meltRes, subject + activity~variable, mean)

#########################################################
## 6. Write the tidy data set in the working directory ##
#########################################################
write.table(endRes, "ResultMean.txt", row.name=FALSE)
