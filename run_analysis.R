
library(dplyr)
setwd("C:/Users/bthor/Desktop/R Work Dir/SmartWatch")

activitylabels <- read.csv("./RawData/activity_labels.txt", sep = " ", header = FALSE)
## featuresdata <- read.csv("./Dataset/features.txt", sep = " ", header = FALSE)
## trainingsubjects <- read.csv("./SmartWatchData/Dataset/features.txt", sep = " ", header = FALSE)
TrainData <- read.table("./RawData/train/X_train.txt", header = FALSE)
TrainLabels <- read.csv("./RawData/train/y_train.txt", header = FALSE)
TrainSubject <- read.csv("./RawData/train/subject_train.txt", header = FALSE)
TestData <- read.table("./RawData/test/X_test.txt", header = FALSE)
TestLabels <- read.csv("./RawData/test/y_test.txt", header = FALSE)
TestSubject <- read.csv("./RawData/test/subject_test.txt", header = FALSE)


TestData <- TestData[,c(1:6,41:46,81:86,121:126,161:166,
                               201,202,214,215,227,228,240,241,253,254,266:271,345:350,
                               424:429,503,504,516,517,529,530,542,543)]

## featuresdataExtract <- featuresdata[c(1:6,41:46,81:86,121:126,161:166,
##                              201,202,214,215,227,228,240,241,253,254,266:271,345:350,
##                              424:429,503,504,516,517,529,530,542,543),]

names(TestData) <- c(
  "BodyAcc-X-mean", "BodyAcc-Y-mean", "BodyAcc-Z-mean", "BodyAcc-X-std", "BodyAcc-Y-std","BodyAcc-Z-std",
  "GravityAcc-X-mean", "GravityAcc-Y-mean", "GravityAcc-Z-mean","GravityAcc-X-std", "GravityAcc-Y-std", "GravityAcc-Z-std",
  "BodyAccJerk-X-mean","BodyAccJerk-Y-mean", "BodyAccJerk-Z-mean", "BodyAccJerk-X-std","BodyAccJerk-Y-std", "BodyAccJerk-Z-std",
  "BodyGyro-X-mean","BodyGyro-Y-mean", "BodyGyro-Z-mean", "BodyGyro-X-std","BodyGyro-Y-std", "BodyGyro-Z-std",
  "BodyGyroJerk-X-mean","BodyGyroJerk-Y-mean", "BodyGyroJerk-Z-mean", "BodyGyroJerk-X-std","BodyGyroJerk-Y-std", "BodyGyroJerk-Z-std",
  "BodyAccMag-mean", "BodyAccMag-std",
  "GravityAccMag-mean", "GarvityAccMag-std",
  "F_BodyAccJerk-mean", "F_BodyAccJerk-std",
  "F_BodyGyroMag-mean", "F_BodyGyroMag-std",
  "F_BodyGyroJerkMag-mean", "F_BodyGyroJerkMag-std",
  "F_BodyAcc-X-mean", "F_BodyAcc-Y-mean", "F_BodyAcc-Z-mean", "F_BodyAcc-X-std", "F_BodyAcc-Y-std", "F_BodyAcc-Z-std",
  "F_BodyAccJerk-X-mean", "F_BodyAccJerk-Y-mean", "F_BodyAccJerk-Z-mean", "F_BodyAccJerk-X-std", "F_BodyAccJerk-Y-std", "F_BodyAccJerk-Z-std",
  "F_BodyGyro-X-mean", "F_BodyGyro-Y-mean", "F_BodyGyro-Z-mean", "F_BodyGyro-X-std", "F_BodyGyro-Y-std", "F_BodyGyro-Z-std",
  "F_BodyAccMag-mean", "F_BodyAccMag-std",
  "BodyBodyAccJerkMag-mean", "BodyBodyAccJerkMag-std", 
  "BodyBodyGyroMag-mean", "BodyBodyGyroMag-std",
  "BodyBodyGyroJerkMag-mean", "BodyBodyGyroJerkMag-std"
  )


TestData$Subject <- TestSubject[,1]  ## Just made that change

names(TestLabels) <- c("ActivityNumber")
names(activitylabels) <- c("ActivityNumber", "ActivityDescription")
MergedTestAct <- merge(TestLabels, activitylabels)  
TestData$Activity <- MergedTestAct[,2]
  
TestData$Pool <- rep(c("Test"), nrow(TestData))

  