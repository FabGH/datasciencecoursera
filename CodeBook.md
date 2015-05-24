## DATA DICTIONARY : ResultMean.txt

### This is the result of a clean up from the Human Activity Recogniton Using Smartphones Dataset Version 1.0. The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Used files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip :
* UCI HAR Dataset/test/X_test.txt        : measurements of 30% of the volunteers (test data) 
* UCI HAR Dataset/test/y_test.txt        : corresponding activity codes of the test data
* UCI HAR Dataset/test/subject_test.txt  : corresponding person id's (subject) of the test data
* UCI HAR Dataset/train/X_train.txt      : measurements of 70% of the volunteers (training data)
* UCI HAR Dataset/train/y_train.txt      : corresponding activity codes of the training data
* UCI HAR Dataset/train/subject_train.txt: corresponding person id's (subject) of the training data
* UCI HAR Dataset/activity_labels.txt    : activity labels
* UCI HAR Dataset/features.txt           : list of all measurements codes on the signals

### Transformations to clean up the data
### Assumption: only mean and standard deviation variables of the 3-axial signals are in scope, no mean frequency, nor angle variables : 
* merge of test measurements with the corresponding activity and subject codes (column bind) to get a complete test data set with activity and subject codes as last columns
* merge of training measurements with the corresponding activity and subject codes (column bind) to get a complete training data set with activity and subject codes as last columns
* merge of test and training data sets (append rows) to get a complete working data set
* add variable names to the data set.  As features.txt is sorted by code and the code is equal to the row number the first features label is the label of the first measurement column, the 2nd to 2nd, ... 
* take a subset of features, retaining only the variables in scope: grep ... mean() and std()
* take a subset from the working data set, selecting only the variables which exist in the features subset (+ subject + activity) ; names(working data set ) %in% ...
* add descriptive activity names: merge activity_labels on activity code and remove activity code
* creation of tiday data set with average of each variable for each activity and subject: using melt and dcast functions. "measure.vars"" are names(dataset without activity and subject) in other wordes the measurements (=features) columns
* write "ResultMean.txt"

### Variables
* subject 2 integer


    Person ID who did the experiment

       1..30

* activity varchar 

    Activity label

        WALKING
        WALKING_UPSTAIRS
        WALKING_DOWNSTAIRS
        SITTING
        STANDING
        LAYING
      
The calculated average fields are numeric. Note the original labels have been kept.  
t-labels are time units, f-labels are frequency units
See features_info to get more details on the variables.

* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
