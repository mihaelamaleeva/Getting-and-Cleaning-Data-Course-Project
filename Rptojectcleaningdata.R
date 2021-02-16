#Setting Working Directory

setwd("C:/Users/Mihaela/AppData/Roaming/SPB_16.6/R-test/Getting-and-Cleaning-Data-Course-Project")

#Downloaded the zip folder and unzip it in created directoryr.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Filename <- "Dataset.zip"
download.file(url, Filename)
unzip(Filename, list=TRUE, exdir = paste0(getwd()),"/Files")

#Reading Tables from the list

features <- read.table(unz("Dataset.zip","UCI HAR Dataset/features.txt"))
activity_labels <- read.table(unz("Dataset.zip","UCI HAR Dataset/activity_labels.txt"))

x_train <- read.table(unz("Dataset.zip","UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(unz("Dataset.zip","UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(unz("Dataset.zip","UCI HAR Dataset/train/subject_train.txt"))

x_test <- read.table(unz("Dataset.zip", "UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(unz("Dataset.zip", "UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(unz("Dataset.zip", "UCI HAR Dataset/test/subject_test.txt"))

#Now I am going to import test and train datasets into Global Enviroment.


colnames(x_train) <- features[,2]
colnames(y_train) <-"activityid"
colnames(subject_train) <- "subjectid"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityid"
colnames(subject_test) <- "subjectid"

colnames(activity_labels) <- c('activityid','activitytype')

#Using cbind and rbind for combining the data into one dataframe
#y and subject are in front of X because they contain id information

train <- cbind(y_train,subject_train,x_train)
test <- cbind(y_test,subject_test,x_test)

FitBitData <- rbind(train,test)

#Extracting mean and standard deviation 

library(dplyr)
FitBitDatasummarized <- FitBitData %>% select(activityid, subjectid, contains("mean"), contains("std"))

##Applying descriptive activity names already done



#Appropriately labels the data set

names(FitBitDatasummarized)<-gsub("Acc", "Accelerometer", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("Gyro", "Gyroscope", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("BodyBody", "Body", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("Mag", "Magnitude", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("^t", "Time", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("^f", "Frequency", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("tBody", "TimeBody", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("-mean()", "Mean", names(FitBitDatasummarized), ignore.case = TRUE)
names(FitBitDatasummarized)<-gsub("-std()", "STD", names(FitBitDatasummarized), ignore.case = TRUE)
names(FitBitDatasummarized)<-gsub("-freq()", "Frequency", names(FitBitDatasummarized), ignore.case = TRUE)
names(FitBitDatasummarized)<-gsub("angle", "Angle", names(FitBitDatasummarized))
names(FitBitDatasummarized)<-gsub("gravity", "Gravity", names(FitBitDatasummarized))

#Making tidy dataset

fitbit <- FitBitDatasummarized %>%
  group_by(subjectid, activityid) %>%
  summarise_all(list(mean)) %>%
  print
write.table(fitbit,"tidydata.txt", row.name= FALSE)
