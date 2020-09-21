
library(dplyr)
setwd("C:/Users/bthor/Desktop/R Work Dir/SmartWatch")

activitylabels <- read.csv("./RawData/activity_labels.txt", sep = " ", header = FALSE)


##### Read in Training Data
TrainData <- read.table("./RawData/train/X_train.txt", header = FALSE)
TrainLabels <- read.csv("./RawData/train/y_train.txt", header = FALSE)
TrainSubject <- read.csv("./RawData/train/subject_train.txt", header = FALSE)

##### Read in Test Data
TestData <- read.table("./RawData/test/X_test.txt", header = FALSE)
TestLabels <- read.csv("./RawData/test/y_test.txt", header = FALSE)
TestSubject <- read.csv("./RawData/test/subject_test.txt", header = FALSE)


##### Keep only the mean and std_dev columns in each of the test and training data sets
TestData <- TestData[,c(1:6,41:46,81:86,121:126,161:166,
                               201,202,214,215,227,228,240,241,253,254,266:271,345:350,
                               424:429,503,504,516,517,529,530,542,543)]


TrainData <- TrainData[,c(1:6,41:46,81:86,121:126,161:166,
                        201,202,214,215,227,228,240,241,253,254,266:271,345:350,
                        424:429,503,504,516,517,529,530,542,543)]


##### Give each of the training and test datasets better column names
names(TestData) <- c(
  "BodyAcc-X-mean", "BodyAcc-Y-mean", "BodyAcc-Z-mean", "BodyAcc-X-std", "BodyAcc-Y-std","BodyAcc-Z-std",
  "GravityAcc-X-mean", "GravityAcc-Y-mean", "GravityAcc-Z-mean","GravityAcc-X-std", "GravityAcc-Y-std", "GravityAcc-Z-std",
  "BodyAccJerk-X-mean","BodyAccJerk-Y-mean", "BodyAccJerk-Z-mean", "BodyAccJerk-X-std","BodyAccJerk-Y-std", "BodyAccJerk-Z-std",
  "BodyGyro-X-mean","BodyGyro-Y-mean", "BodyGyro-Z-mean", "BodyGyro-X-std","BodyGyro-Y-std", "BodyGyro-Z-std",
  "BodyGyroJerk-X-mean","BodyGyroJerk-Y-mean", "BodyGyroJerk-Z-mean", "BodyGyroJerk-X-std","BodyGyroJerk-Y-std", "BodyGyroJerk-Z-std",
  "BodyAccMag_mean", "BodyAccMag_std",
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


names(TrainData) <- c(
  "BodyAcc-X-mean", "BodyAcc-Y-mean", "BodyAcc-Z-mean", "BodyAcc-X-std", "BodyAcc-Y-std","BodyAcc-Z-std",
  "GravityAcc-X-mean", "GravityAcc-Y-mean", "GravityAcc-Z-mean","GravityAcc-X-std", "GravityAcc-Y-std", "GravityAcc-Z-std",
  "BodyAccJerk-X-mean","BodyAccJerk-Y-mean", "BodyAccJerk-Z-mean", "BodyAccJerk-X-std","BodyAccJerk-Y-std", "BodyAccJerk-Z-std",
  "BodyGyro-X-mean","BodyGyro-Y-mean", "BodyGyro-Z-mean", "BodyGyro-X-std","BodyGyro-Y-std", "BodyGyro-Z-std",
  "BodyGyroJerk-X-mean","BodyGyroJerk-Y-mean", "BodyGyroJerk-Z-mean", "BodyGyroJerk-X-std","BodyGyroJerk-Y-std", "BodyGyroJerk-Z-std",
  "BodyAccMag_mean", "BodyAccMag_std",
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


### Add the subject into either the test or train dataset in a new column
TestData$Subject <- TestSubject[,1]
TrainData$Subject <- TrainSubject[,1]


### Add the actual activity description against just the activity number, for both train and test
## First we give the the same column names so that the merge works
names(activitylabels) <- c("ActivityNumber", "ActivityDescription")
names(TestLabels) <- c("ActivityNumber")
names(TrainLabels) <- c("ActivityNumber")

### Add activity descriptions into the Test Data set
MergedTestAct <- merge(TestLabels, activitylabels, sort = FALSE)  
TestData$Activity <- MergedTestAct[,2]

### Add activity descriptions into the Test Data set
MergedTrainAct <- merge(TrainLabels, activitylabels, sort = FALSE)  
TrainData$Activity <- MergedTrainAct[,2]

### Combine the tables
Data <- rbind(TrainData, TestData)


####  From the data set in step 4, creates a second,
#### independent tidy data set with the average of each variable for each activity and each subject.


GroupActivity <- Data %>%
  group_by(Activity, Subject) %>%
  summarize(MeanBodyAccMag = mean(BodyAccMag_mean),
  STDBodyAccMag = mean(BodyAccMag_std))

write.table(GroupActivity, file = "activities.txt", sep = "|")

