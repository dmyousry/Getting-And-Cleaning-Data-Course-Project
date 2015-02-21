#Getting and Cleaning Data Project

##CodeBook
-----------
 
### Project coding requirement

Create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### The code explained

**Data Loading and Preparation**
*Read training data
*Read testing data
*Read features and activities names
*Assigning column lables

`x_train` the training dataset.

`y_train` the activities training dataset.

`subject_train` the subject persons training dataset.

`x_test` the test dataset.

`y_test` the activities test dataset.

`subject_test` the subject persons test dataset.



**1. Merge the training and the test sets to create one data set**

*Chose to merge each data set separately, making each data set (train/test). 
Start by Subject, then Activity, then the Observations. 
Training dataset has 7352 observations. Testing dataset has 2947 observations. 
Then merged all in one dataset that has 10299 observations, of 563 variables*

`train_data` merged training data.

`test_data` merged test data.

`merged_data` all data merged.

**2. Extract only the measurements on the mean and standard deviation for each measurement**
*grep the column names that has mean or std in it. Get column indeces. Subset them out. 
The result set, will maintain that Subject_ID, and Activity_ID for each reading*

`mean_or_std_indeces` indices for mean and std deviation vectors.

`merged_mean_std_data` subsetted data containing mean and std deviation vectors.

 **3. Uses descriptive activity names to name the activities in the data set**
*Merged_mean_std_data[,2] contains the Activity_ID in the data set,
this is matched with the Activity_Name in activities[ ,2], 
then assigned to merged_mean_std_data activity column, 
then change the label from Activity_ID to Activity_Name*

**4. Appropriately labels the data set with descriptive variable names**
*names(vector)<-namesvector*

**5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject**

*use ddply on merged_mean_std_data, with columns "Subject_ID" & "Activity_Name"*

`average_data` the average dataset

`average_data.txt` the output file









