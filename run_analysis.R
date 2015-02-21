#setwd("/Users/dmyousry/Documents/DIAA.Data/Personal/Enablement/Coursera-DataScience/GettingAndCleaningData/project/UCI HAR Dataset")

########################### Project Getting and Cleaning Data ################
# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
###############################################################################


###############################################################################
# Preparation - Loading Data
###############################################################################

#Read training data 
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

#Read testing data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#Read features and activities names
features<-read.table("features.txt")
activities<-read.table("activity_labels.txt")

#Assigning column lables
names(x_train)<-features[,2]
names(x_test)<-features[,2]

names(y_train)<-"Activity_ID"
names(y_test)<-"Activity_ID"

names(subject_train)<-"Subject_ID"
names(subject_test)<-"Subject_ID"

names(features)<-c("Feature_ID","Feature_Name")
names(activities)<-c("Activity_ID", "Activity_Name")

###############################################################################
# 1. Merges the training and the test sets to create one data set.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Choosen to merge each data set separately, making each data set (train/test)
# start by Subject, then Activity, then the Observations 
# training dataset has 7352 observations
# testing dataset has 2947 observations
# then merged all in one dataset that has 10299 observations, of 563 variables
###############################################################################
train_data<-cbind(subject_train, y_train, x_train)
test_data<-cbind(subject_test, y_test, x_test)
merged_data<-rbind(train_data, test_data)


###############################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# grep the column names that has mean or std in it
# get column indeces
# subset them out
# the result set, will maintain that Subject_ID, and Activity_ID for each 
# reading
###############################################################################

# grep the column names that has mean or std in it
mean_or_std_indeces<-grep("mean|std",names(merged_data))

# subset the data including Subject_ID, and Activity_ID for each reading
merged_mean_std_data<-merged_data[,c(1,2,mean_or_std_indeces)]


###############################################################################
# 3. Uses descriptive activity names to name the activities in the data set
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# merged_mean_std_data[,2] contains the Activity_ID in the data set
# this is matched with the Activity_Name in activities[ ,2]
# then assigned to merged_mean_std_data activity column
# then change the label from Activity_ID to Activity_Name
###############################################################################

merged_mean_std_data[,2]<-activities[merged_mean_std_data[,2],2]
merged_data[,2]<-activities[merged_data[,2],2] 
names(merged_mean_std_data)[2]<-"Activity_Name"
names(merged_data)[2]<-"Activity_Name"

###############################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###############################################################################

# Already covered in the data preparation step
names(merged_mean_std_data)
names(merged_data)


###############################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# use ddply on merged_mean_std_data, with columns "Subject_ID" & "Activity_Name"
###############################################################################

average_data<-ddply(merged_mean_std_data, c("Subject_ID","Activity_Name"), 
                    numcolwise(mean))

write.table(average_data, file = "average_data.txt", row.name=FALSE)

#######################          End of project     ###########################

