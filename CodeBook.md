---
title: "CodeBook: Cleaning and Getting Data - Course project"
author: "Manuel Torres-Sahli"
date: "September 27, 2015"
output: html_document
---

This document describes the tidy data set produced from the data linked to from the course website, that represent data collected from the accelerometers from the Samsung Galaxy S II smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following information is provided in this CodeBook:  
        1. Some information about the original data, extracted from the original readme, info and codebook-like files. (If you don't want specific info about the original data, skip this section.)  
        2. A general description of the cleaned data set  
        3. The work and transformations performed to clean up the data  
        4. A description of the variables of the cleaned data set  

### 1. Original data info
From original README.txt:
```
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

[...]

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
```

From original features_info.txt:
```

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

### 2. Cleaned Data Set

The clean data set was produced with the `run_analysis.R` script. This data set contains only the mean and standard deviation for each measurement of the original data set (66 variables). For each variable is provided the average measurement for each activity (6) an each subject (30). This gives 180 observations for 66 measurement mean and standard deviation averages.

### 3. Data Cleaning Procedure

All steps for cleaning the data are done within the `run_analysis.R` script. So a really detailed explanation of this procedure could be found there. Also, a not so detailed step-by-step description is given in the `README.md` file. The script does the following:
        - Merges the original training and the test sets to create one data set.
        - Extracts only the measurements on the mean and standard deviation for each measurement. 
        - Uses the labels in `activity_labels.txt` to name the activities in the data set
        - Appropriately labels the data set with variable names taken from `features.txt`. 
        - Creates a new independent tidy data set with the average of each variable for each activity and each subject.
        
### 4. Variables description
  
  
  
 activity  
        Description: Activity performed whilst measurement was captured  
                Values (factor):  
                1. WALKING  
                2. WALKING_UPSTAIRS  
                3. WALKING_DOWNSTAIRS  
                4. SITTING  
                5. STANDING  
                6. LAYING  
        
 subject  
Description: Subject id number
Values (integer): 1-30 Integer
 
 tBodyAcc.mean...X          
 tBodyAcc.mean...Y  
 tBodyAcc.mean...Z  
 Description: Time domain body linear acceleration signals mean for each of 3 axis.  
 Values (numeric): -1 to 1
 
 
 tGravityAcc.mean...X       
 tGravityAcc.mean...Y        
 tGravityAcc.mean...Z        
 Description: Time domain gravity linear acceleration signals mean for each of 3 axis.  
 Values (numeric): -1 to 1  
 
 
tBodyAccJerk.mean...X      
tBodyAccJerk.mean...Y       
tBodyAccJerk.mean...Z  
 Description: Time domain body acceleration Jerk signals mean for each of 3 axis.  
 Values (numeric): -1 to 1  
 
 
tBodyGyro.mean...X         
tBodyGyro.mean...Y          
tBodyGyro.mean...Z  
 Description: Time domain body angular velocity signals mean for each of 3 axis.  
 Values (numeric): -1 to 1  
 
 
tBodyGyroJerk.mean...X     
tBodyGyroJerk.mean...Y      
tBodyGyroJerk.mean...Z  
 Description: Time domain gravity angular velocity Jerk signals mean for each of 3 axis.  
 Values (numeric): -1 to 1  
 

tBodyAccMag.mean..  
 Description: Time domain magnitud of three-dimensional body linear acceleration signals mean.  
 Values (numeric): -1 to 1  


tGravityAccMag.mean..  
Description: Time domain magnitud of three-dimensional gravity linear acceleration signals mean.  
 Values (numeric): -1 to 1  
 
 
tBodyAccJerkMag.mean..  
Description: Time domain magnitud of three-dimensional body linear acceleration Jerk signals mean.  
 Values (numeric): -1 to 1  
 
 
tBodyGyroMag.mean..  
Description: Time domain magnitud of three-dimensional body angular velocity signals mean.  
 Values (numeric): -1 to 1  
 
 
tBodyGyroJerkMag.mean..  
Description: Time domain magnitud of three-dimensional body angular velocity Jerk signals mean.  
 Values (numeric): -1 to 1  
 

fBodyAcc.mean...X           
fBodyAcc.mean...Y          
fBodyAcc.mean...Z  
Description: Frequency domain body linear acceleration signals mean for each of 3 axis.  
 Values (numeric): -1 to 1  
 

fBodyAccJerk.mean...X       
fBodyAccJerk.mean...Y      
fBodyAccJerk.mean...Z  
 Description: Frequency domain body linear acceleration Jerk signals mean for each of 3 axis.  
 Values (numeric): -1 to 1
 

fBodyGyro.mean...X          
fBodyGyro.mean...Y         
fBodyGyro.mean...Z  
 Description: Frequency domain body angular velocity signals mean for each of 3 axis.  
 Values (numeric): -1 to 1
 

fBodyAccMag.mean..  
 Description: Frequency domain magnitud of three-dimensional body linear acceleration signals mean.  
 Values (numeric): -1 to 1 


fBodyBodyAccJerkMag.mean..  
 Description: Frequency domain magnitud of three-dimensional body linear acceleration Jerk signals mean.  
 Values (numeric): -1 to 1  



fBodyBodyGyroMag.mean..  
 Description: Frequency domain magnitud of three-dimensional body angular velocity signals mean.  
 Values (numeric): -1 to 1  
  
  
fBodyBodyGyroJerkMag.mean..  
 Description: Frequency domain magnitud of three-dimensional body angular velocity Jerk signals mean.  
 Values (numeric): -1 to 1  


tBodyAcc.std...X           
tBodyAcc.std...Y            
tBodyAcc.std...Z  
Description: Time domain body linear acceleration signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1



tGravityAcc.std...X        
tGravityAcc.std...Y         
tGravityAcc.std...Z  
Description: Time domain gravity linear acceleration signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1


tBodyAccJerk.std...X       
tBodyAccJerk.std...Y        
tBodyAccJerk.std...Z  
Description: Time domain body acceleration Jerk signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1


tBodyGyro.std...X          
tBodyGyro.std...Y           
tBodyGyro.std...Z  
Description: Time domain body angular velocity signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1


tBodyGyroJerk.std...X      
tBodyGyroJerk.std...Y       
tBodyGyroJerk.std...Z  
Description: Time domain gravity angular velocity Jerk signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1


tBodyAccMag.std..  
Description: Time domain magnitud of three-dimensional body linear acceleration signals standard deviation.  
Values (numeric): -1 to 1


tGravityAccMag.std..  
Description: Time domain magnitud of three-dimensional gravity linear acceleration signals standard deviation.  
Values (numeric): -1 to 1

tBodyAccJerkMag.std..  
Description: Time domain magnitud of three-dimensional body linear acceleration Jerk signals standard deviation.  
Values (numeric): -1 to 1


tBodyGyroMag.std..  
Description: Time domain magnitud of three-dimensional body angular velocity signals standard deviation.  
Values (numeric): -1 to 1

tBodyGyroJerkMag.std..  
Description: Time domain magnitud of three-dimensional body angular velocity Jerk signals standard deviation.  
Values (numeric): -1 to 1


fBodyAcc.std...X            
fBodyAcc.std...Y           
fBodyAcc.std...Z  
Description: Frequency domain body linear acceleration signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1


fBodyAccJerk.std...X        
fBodyAccJerk.std...Y       
fBodyAccJerk.std...Z  
Description: Frequency domain body linear acceleration Jerk signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1

fBodyGyro.std...X           
fBodyGyro.std...Y          
fBodyGyro.std...Z  
Description: Frequency domain body angular velocity signals standard deviation for each of 3 axis.  
Values (numeric): -1 to 1

fBodyAccMag.std..  
Description: Frequency domain magnitud of three-dimensional body linear acceleration signals standard deviation.  
Values (numeric): -1 to 1


fBodyBodyAccJerkMag.std..  
Description: Frequency domain magnitud of three-dimensional body linear acceleration Jerk signals standard deviation.  
Values (numeric): -1 to 1


fBodyBodyGyroMag.std..  
Description: Frequency domain magnitud of three-dimensional body angular velocity signals standard deviation.  
Values (numeric): -1 to 1


fBodyBodyGyroJerkMag.std..  
Description: Frequency domain magnitud of three-dimensional body angular velocity Jerk signals standard deviation.  
Values (numeric): -1 to 1