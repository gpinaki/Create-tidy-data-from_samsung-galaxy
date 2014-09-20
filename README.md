# Create_tidy_data_from_samsung_galaxy
This repository contains the code for the project of the course Getting And Cleaning data by Coursera run_analysis.R

## Overview
Script to prepare the tidy data set using the raw data obtained from Samsung Galaxy S smartphone. 

## Background
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

#### The dataset includes the following files

* 'README.txt'
* 'features_info.txt' -  Shows information about the variables used on the feature vector.
* 'features.txt'- List of all features.
* 'activity_labels.txt'- Links the class labels with their activity name.
* 'train/X_train.txt'- Training set.
* 'train/y_train.txt'- Training labels.
* 'test/X_test.txt'- Test set.
* 'test/y_test.txt'- Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Assumption and Prerequisites
The script run_analysis.R should run from the user's working directory. The Samsung data 
needs to be in the same directory where the script exists. 

Following files and directories need to exist in the same directory where run_analysis.R is present.
* activity_labels.txt
* features.txt
* features_info.txt
* test  (directory)
* train (directory)
Following files must exist under the test directory
* X_test.txt
* y_test.txt
* subject_test.txt
Following files must exist under the train directory
* X_train.txt
* y_train.txt
* subject_train.txt

## Workflow

run_analysis.R does the following steps:
1. Read the following files for the train set and load into the data-frames. Rename column names to meaningful names.  
	* X_train.txt
	* y_train.txt
	* subject_train.txt
2. Read the following files for the train set and load into the data-frames. Rename column names to meaningful names.  
	* X_test.txt
	* y_test.txt
	* subject_test.txt
3. Rename the column names of X_train dataset with the second column of the features.txt file
   Rename the column names of X_test dataset with the second column of the features.txt file
4. Horizontally bind the data-frames: X_train,y_train and subject_train
   Horizontally bind the data-frames: X_test,y_test and subject_test
5. Vertically join the train and test data-frames. 
6. Subset the dataset vertically by extracting only the measurements on the mean and standard deviation for each measurement. 
   We extracted all column names with strings "mean" and "std" inside it. Note that meanFreq also included just in case if   required
7. Use descriptive activity names to name the activities in the data set. To add descriptive activity names, we have merged the act_label data-frame with our combined data frame. 
8. The code then appropriately labels the data set with descriptive variable names. To do that, we have made all variables lower case, removed '-' and '()' as per variable naming standards for a tidy data set.
9. From the data set in previous step, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject using the aggregate() function. 
10. The script finally writes the data-frame using write.table() in a text file named tidy_dataset.txt in the same working directory.

## Execution

To generate the final tidy data set do the following steps:
1. Set the working directory to the location where the  run_analysis.R and above data files exist.
2. Run the following command in R: 
		source("./run_analysis.R")

## Verification

In the same directory location the new text file "tidy_dataset.txt" will be created having the tidy data.



