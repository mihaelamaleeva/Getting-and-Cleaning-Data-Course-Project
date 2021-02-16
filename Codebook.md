1. Download the zip file from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the folder and extract the needed tables listed below.

The Rptojectcleaningdata.R script performs the following: 

- Assign each data to variables keeping the txt name: 
features <- features.txt
activity_labels <- activity_labels.txt
X_test <- X_test.txt
y_test <- y_test.txt
subject_test <-subject_test.txt
X_train <-X_train.txt
y_train <-y_train.txt
subject_train <- subject_train.txt

-Merges the training and the test sets to create one data set:

cbind for combaining all train data into train and all test data into test.
rbind is used for combaining train and test 

-extracting mean and standard deviation
library dplyr is used and chain commands.

-setting descriptive names for the columns
All the colomn names were substituted with meaningful words. For example "Acc" is substituted for "Accelerometer" and so on.

-All the clean data is then combined and grouped into a datased where mean and std are summarized.

text file called fitbitactivity is written with the clean dataset.
