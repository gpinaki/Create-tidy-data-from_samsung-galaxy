 ##################### Project ########################################
 
 #### Assumption on Directory location ######
 # The file run_analysis.R should be located under the main directory where the Samsung data is. It should be your working directory as well. 
 
 # First clear all objects from the memory
 rm(list=ls())

 # Read the following files for the train set. Rename column names to meaningful names.
  x_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  x_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  act_label <- read.table("activity_labels.txt", colClasses = "character")
  features <- read.table("features.txt", colClasses = "character")
  
# Rename column names to meaningful names.

colnames(y_test) <- "trainlabel"
colnames(subject_test) <- "subject"
colnames(act_label) <- c("trainlabel", "activity")
colnames(y_train) <- "trainlabel"
colnames(subject_train) <- "subject"

# Assign the column names of x_train and x_test datasets with the second column of the features.txt file
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

########## Step 1 START #############################
# Binds the training and the test sets to create one data set.
# In this step we merge the data sets by binding rows and columns : using cbind and rbind functions

tmp_data1 <- rbind(cbind(y_train,subject_train,x_train),cbind(y_test,subject_test,x_test))

############ Step 1 FINISHED ########################

############ Step 2 START ###########################
# Extract only the measurements on the mean and standard deviation for each measurement.
# We extract all column names with strings "mean" and "std". Note that meanFreq also included just in case if required
# First we create a list of columns using the grep function and then used the list to subset the previous data set

mean_std_col_list <- c(grep( "mean()",names(tmp_data1), value = TRUE),grep( "std",names(tmp_data1), value = TRUE))
tmp_data2 <- tmp_data1[,c("trainlabel","subject",mean_std_col_list)]

############ Step 2 FINISHED ########################

############ Step 3 START ###########################
# Use descriptive activity names to name the activities in the data set
# To add descriptive activity names, we have merged act_label with out previous data frame. Then we removed any  unwanted column from the set.

tmp_data3 <- merge(tmp_data2, act_label, by="trainlabel")
tmp_data3$activity <- as.factor(tmp_data3$activity)

############ Step 3 FINISHED ########################

############### Step 4 START ########################
# Appropriately labels the data set with descriptive variable names
# We have made all variables lower case, removed '-' and '()' as per variable naming standards for tidy data

colnames(tmp_data3) <- gsub("\\(\\)","",tolower(gsub("-", "",colnames(tmp_data3))))

############ Step 4 FINISHED ########################

############ Step 5 START ###########################
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# We collapse the rows by taking average. Also reshaped the data by removing couple of unwanted columns.
tidy_data <- aggregate(.~subject + activity, data=tmp_data3, mean)
tidy_data <- tidy_data[,-3]

############ Step 5 FINISHED #########################

# Finally write teh data into a file tidy_dataset.txt

write.table(tidy_data, file = "./tidy_dataset.txt", row.names = FALSE)

