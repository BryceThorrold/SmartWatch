library(data.table)
library(tidyverse)
setwd("C:/Users/bthor/Desktop/R Work Dir/SmartWatch")


##############
## X dimension is the readings from the watch  
## Y dimension is the observed activity at the time
## sub dimension is the person doing the activity
##############


### Read in the baseline features and activities
features <- read.table("./RawData/features.txt", col.names = c("n","fun"))
activities <- read.table("./RawData/activity_labels.txt", col.names = c("code", "activity"))

### Read in the Test data set
subtest <- read.table("./RawData/test/subject_test.txt", col.names = "subj")
x_test <- read.table("./RawData/test/X_test.txt", col.names = features$fun)
y_test <- read.table("./RawData/test/y_test.txt", col.names = "code")


### Read in the Train data set
subtrain <- read.table("./RawData/train/subject_train.txt", col.names = "subj")
x_train <- read.table("./RawData/train/X_train.txt", col.names = features$fun)
y_train <- read.table("./RawData/train/y_train.txt", col.names = "code")


### Combine the test and train datasets into just x,y and subject datasets
x_set <- rbind(x_test, x_train)
y_set <- rbind(y_test, y_train)
sub_set <- rbind(subtest, subtrain)

### Extract the columns that contain either mean or std measures separately from x data set
mean_set <- x_set[, grepl("mean()", names(x_set))]
std_set <- x_set[, grepl("std()", names(x_set))]

### And then combine them back so you have only columns with mean and STD
fin_set <- cbind(mean_set, std_set)


### Tidy up subject data set by translating the code into the activity name and naming the column
y_set$code <- activities[y_set$code, 2]
names(y_set) = "activity"

### Now merge the 3 seprate datasets into 1 final datasets
merge_set <- cbind(fin_set, y_set, sub_set)

## Tidy up the names a bit by substituting short descriptions for longer ones
names(merge_set)<-gsub("Acc", "Accelerometer", names(merge_set))
names(merge_set)<-gsub("Gyro", "Gyroscope", names(merge_set))
names(merge_set)<-gsub("BodyBody", "Body", names(merge_set))
names(merge_set)<-gsub("Mag", "Magnitude", names(merge_set))
names(merge_set)<-gsub("^t", "Time", names(merge_set))
names(merge_set)<-gsub("^f", "Frequency", names(merge_set))
names(merge_set)<-gsub("tBody", "TimeBody", names(merge_set))
names(merge_set)<-gsub("-mean()", "Mean", names(merge_set), ignore.case = TRUE)
names(merge_set)<-gsub("-std()", "STD", names(merge_set), ignore.case = TRUE)
names(merge_set)<-gsub("-freq()", "Frequency", names(merge_set), ignore.case = TRUE)
names(merge_set)<-gsub("angle", "Angle", names(merge_set))
names(merge_set)<-gsub("gravity", "Gravity", names(merge_set))


### Aggregate the merged set by subject and activity, computing the mean for each and then ordering by subj and activity
final_set<-aggregate(. ~subj + activity, merge_set, mean)
final_set <- final_set[order(final_set$subj,final_set$activity),]


write.table(final_set, file = "tidydata.txt",row.name=FALSE)




