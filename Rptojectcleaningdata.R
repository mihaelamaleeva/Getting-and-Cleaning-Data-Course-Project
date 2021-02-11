#Downloaded the zip folder and unzip it on my computer.
#Now I am going to import test and train datasets into Global Enviroment.


colnames(X_train) <- features[,2]
colnames(y_train) <-"activityid"
colnames(subject_train) <- "subjectid"

colnames(X_test) <- features[,2] 
colnames(y_test) <- "activityid"
colnames(subject_test) <- "subjectid"

colnames(activity_labels) <- c('activityid','activitytype')

#Using cbind and rbind for combining the data into one dataframe
#y and subject are in front of X because they contain id information

train <- cbind(y_train,subject_train,X_train)
test <- cbind(y_test,subject_test,X_test)

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
write.table(fitbit,"fitbitactivity.txt")
