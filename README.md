---
title: "Course Project: Getting and Cleaning Data"
author: "Manuel Torres-Sahli"
date: "September 27, 2015"
output: html_document
---

#####Repository for Course Project: 'Getting and Cleaning Data' (getdata-032) from John Hopkins University's Data Science Specialization on Coursera. This repository contains a script and a codebook. `CodeBook.md` describes the variables, the data, and the work and transformations performed to clean up the data as asked for the assignment.

### The Script

The script `run_analysis.R` is one complete solution to the assignment. It uses the raw Samsung dataset to create a tidy data set with the mean and standard deviation of each measure for each activity and each subject. If the dataset isn't in the working folder, the script attempts to download it. The script uses base R package and dplyr package; if the dplyr package is not installed the script attempts to install it before loading it.

#### What the script does, step-by-step:

- Checks if data is available in working directory, looking for `train` and `test` folders. If it is in a subfolder (named `UCI HAR Dataset`) or a zip file (named `getdata-projectfiles-UCI HAR Dataset.zip`), the script set the adequate working directory and unzips if necessary.

- Loads and merges the training (`X_train.txt`) and test (`X_test.txt`) data sets to create one data set. Inertial Signals are ommitted as they would have been left out at last anyway.

- Appropriately labels the merged data set with descriptive variable names. For this, the 'features.txt' file is used. These labels are descriptive in contrast with "V1", "V2", etcetera. i.e. they are descriptive in the sense of substantively interpretable; using not full words, but readable abreviations. These are composed abreviations of multiple aspects of the recorded signal. More extended labels wouldn't have been fitted for a data frame or table. The comprehensive description of what they mean is in the CodeBook.

- Extracts only the measurements on the mean and standard deviation for each measurement. For this the variable names assigned in the previous step are used, selecting only the variables with `mean()` and `std()` in their labels.

- Merges the selected measurements data set with the subjects id (`subject_train.txt`, `subject_test.txt`) and activities id (`y_train.txt`, `y_test.txt`) data, creating a column for each one labeled 'subject' and 'activity' respectively.

- Uses descriptive activity names from `activity_labels.txt` to name the activities in the merged data set. These values are assigned as factor levels.

- From the fully labeled data set, creates a second, independent tidy data set with the average of each nongrouping variable for each activity and each subject. This is done grouping the dataset by activity and subject with dplyr package.

- Saves this last data set in the original working folder, and in the script internal working folder `./data/UCI HAR Dataset` if it was set at the start, as `getdata_project.txt`.
       
These steps almost replicates the order of the instructions given for the assignment. Only the  `Step 4` of the assignment is done in a different moment; before `Step 2`. This is because the descriptive variable names are used to select variables with mean and standard deviation measures.

***

Thanks to *__David Hood__* for his [awesome guide](https://class.coursera.org/getdata-032/forum/thread?thread_id=26); it really helped me to order my ideas and come to a good solution, learning a lot in the proces.

Also, the [R Markdown Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf) from [rmarkdown.rstudio.com](http://rmarkdown.rstudio.com/) was an excelent support for creating this README.md and the CodeBook.md.