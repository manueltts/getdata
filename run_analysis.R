#######
# Intro
#######
#
# This script uses the raw 'UCI HAR Dataset' to create a tidy data frame with
#the mean and standard deviation of each measure for each activity and each
#subject. If the dataset isn't in the working folder, the script attempts to
#download it. The script uses base R package and dplyr package.
#
# In brief, this is what the script does:
#       1. Merges the training and the test sets to create one data set.
#       2.a Appropriately labels the data set with descriptive variable names.
#       2.b Extracts only the measurements on the mean and standard deviation
#       for each measurement. 
#       3. Uses descriptive activity names to name the activities in the data
#       set
#       4. From the data set in step 4, creates a second, independent tidy data
#       set with the average of each variable for each activity and each
#       subject.
#       5. Saves this data set in the working folder as 'getdata_project.txt'
#       
#       These steps almost replicates the order of the instructions given.


############
# Preliminar: check data
############

# The next if-else chain sets "UCI HAR Dataset" or a folder with equivalent files
#content as the working directory. The steps are:
#
# 1. check if working directory has 'train' and 'test' folders; if that is
#TRUE, uses current as working directory; else...
# 2. check if 'UCI HAR Dataset' folder with 'train' and 'test subfolders is in 
#working directory; if that is TRUE, set "./UCI HAR Dataset" as working
#directory; else...
# 3. check if 'getdata-projectfiles-UCI HAR Dataset.zip' is in working directory;
#if that is TRUE unzip content to "./data" and sets "./data/UCI HAR Dataset" as
#working directory.
# 4. Download and unzip 'getdata-projectfiles-UCI HAR Dataset.zip' to './data';
#sets './data/UCI HAR Dataset' as working directory

WD <- getwd()
if(dir.exists('test') & dir.exists('train')) {
        message("Using current working directory")
} else if(dir.exists('UCI HAR Dataset/train') & 
          dir.exists('UCI HAR Dataset/test/')) {
        setwd("./UCI HAR Dataset")
        message("Changing working directory to './UCI HAR Dataset'")
} else if(file.exists('getdata-projectfiles-UCI HAR Dataset.zip') &
          !dir.exists('./data/UCI HAR Dataset')) {
        if (!dir.exists("./data")) {
                dir.create("./data")
        }
        message("Extracting zipped dataset")
        unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir = "./data")
        setwd("./data/UCI HAR Dataset")
        message("Working directory changed to './data/UCI HAR Dataset'")
} else {
        if (!dir.exists("./data")) {
                dir.create("./data")
        }
        if (!file.exists("./data/getdata-projectfiles-UCI HAR Dataset.zip")) {
                message("Downloading dataset. If you don't have internet
                        connection -and maybe if you are not using windows-
                        you would have to download dataset manually, and
                        put it into the working directory")
                download.file(
                        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                        dest="./data/getdata-projectfiles-UCI HAR Dataset.zip", mode="wb")
        }
        message("Extracting zipped dataset")
        unzip("./data/getdata-projectfiles-UCI HAR Dataset.zip", exdir = "./data")
        setwd("./data/UCI HAR Dataset")
        message("Working directory changed to './data/UCI HAR Dataset'")
}


########
# Step 1: Merges the training and the test sets to create one data set.
########

# This also load activity and features labels; and merges subject and activity
#labels data.

# Load:
#       data sets
#       set activity labels id
#       activity and features labels
#       subjects id

training_set <- read.table("train/X_train.txt")
test_set <- read.table("test/X_test.txt")

training_labels <- read.table("train/y_train.txt")
test_labels <- read.table("test/y_test.txt")

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

training_subjects <- read.table("./train/subject_train.txt")
test_subjects <- read.table("./test/subject_test.txt")

# Merge (rbind):
#       test_set and training_set into data_set
#       test_labels and training_labels into data_labels
#       test_subjects and training_subjects into data_subjects

data_set <- rbind(test_set, training_set)
data_labels <- rbind(test_labels, training_labels)
data_subjects <- rbind(test_subjects, training_subjects)

# Check for dplyr package, installs it if necessary, and load it.

if("dplyr" %in% rownames(installed.packages()) == FALSE) {
        message("dplyr package not found. Installing dplyr package")
        install.packages("dplyr")
} else {
        message("dplyr package already installed")
}
library(dplyr)

# Convert data frames into data frame tables
data_set <- tbl_df(data_set)
data_labels <- tbl_df(data_labels)
data_subjects <- tbl_df(data_subjects)


########
# Step 2: Extracts only the measurements on the mean and standard deviation for
######## each measurement.
#        
# Assign features values to variable names in data_set
colnames(data_set) <- features[, 2]

# Create data_set2 and select columns with 'mean()' or 'std()' variables
data_set2 <- data_set

# Rename all variables with valid and nonduplicate names
        valid_column_names <- make.names(names=names(data_set2), 
                                         unique=TRUE, allow_ = TRUE)
        names(data_set2) <- valid_column_names
        data_set2 <- data_set2[, !duplicated(names(data_set)) ]

# Use dplyr to select mean and std columns
data_set2 <- select(data_set2, contains("mean..", ignore.case = FALSE),
                    contains("std.."))


########
# Step 3: Uses descriptive activity names to name the activities 
########  in the data set.

# Merge (cbind) labels and sets
data_subjects <- rename(data_subjects, subject = V1)
data_labels <- rename(data_labels, activity = V1)
data_set3 <- cbind(data_subjects, data_labels, data_set2)

# Replace activity numbers with activity labels, using factor levels
data_set3$activity <- as.factor(data_set3$activity)
levels(data_set3$activity) <- activity_labels[, 2]


########
# Step 4: Appropriately labels the data set with descriptive variable names. 
########
# 
#  This has been done in step 2, before selecting mean and std variables. The
# assigned labels were taken from the 'features.txt' data. These labels ar
# descriptive in contrast with "V1", "V2", etcetera. i.e. they are descriptive 
# in the sense of substantively interpretable. Labels are composed abreviations
# of multiple aspects of the recorded signal. More extended labels wouldn't
# have been fitted for a data frame or table. The comprehensive description of 
# what they mean is in the CodeBook.


########
# Step 5: From the data set in step 4 (3), creates a second, independent tidy
########  data set with the average of each variable for each activity and each
#         subject.
    
# Use dplyr to group by activity and subject
data_set4 <- group_by(data_set3, activity, subject)

#  Use dplyr to summarize each variable (except gruping variables) by each
# activity and each subject
data_set5 <- summarise_each(data_set4, funs(mean))

#  Saves last data frame into 'getdata_project.txt' in both original working
# directory and script working directory. Returns to original working directory.       
write.table(data_set5, "getdata_project.txt", row.names = FALSE)
message("Coming back to your original working directory")
setwd(WD)
write.table(data_set5, "getdata_project.txt", row.names = FALSE)
message("A copy of the las tidy data frame has been saved in your original
        working directory as 'getdata_project.txt', as well as in the script
        working directory.")