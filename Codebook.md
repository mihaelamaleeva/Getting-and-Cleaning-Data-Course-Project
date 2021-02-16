

# The Rptojectcleaningdata.R script performs the following: 
1. Download the zip file 
2. Creating a list with the files in the zip folder
3.Using unz to extract the 8 tables listed below.

4.Assign each data to variables keeping the txt name: 
features <- features.txt
activity_labels <- activity_labels.txt
X_test <- X_test.txt
y_test <- y_test.txt
subject_test <-subject_test.txt
X_train <-X_train.txt
y_train <-y_train.txt
subject_train <- subject_train.txt

5.Merges the training and the test sets to create one data set:

cbind for combaining all train data into train and all test data into test.
rbind is used for combaining train and test 

6.extracting mean and standard deviation
library dplyr is used and chain commands.

7.setting descriptive names for the columns
All the colomn names were substituted with meaningful words. For example "Acc" is substituted for "Accelerometer" and so on.

8.All the clean data is then combined and grouped into a datased where mean and std are summarized.

9.text file called tidydata.txt is written with the clean dataset.
