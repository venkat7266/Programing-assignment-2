setwd("C:\Users\xps\Downloads\getdata_projectfiles_UCI HAR Dataset")
# ===============================================================
# run_analysis.R
# Course Project: Getting and Cleaning Data
# Author: <Your Name>
# ===============================================================

# STEP 0: Load required library
library(dplyr)  # Install first if not installed: install.packages("dplyr")

# STEP 1: Read all the data files ---------------------------------------------

# Read feature names and activity labels
features <- read.table("features.txt", col.names = c("index", "feature"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))

# Read training data
x_train <- read.table("train/X_train.txt", col.names = features$feature)
y_train <- read.table("train/y_train.txt", col.names = "code")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

# Read test data
x_test <- read.table("test/X_test.txt", col.names = features$feature)
y_test <- read.table("test/y_test.txt", col.names = "code")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")

# STEP 2: Merge training and test sets ----------------------------------------

X <- rbind(x_train, x_test)      # Combine measurement data
Y <- rbind(y_train, y_test)      # Combine activity codes
Subject <- rbind(subject_train, subject_test)  # Combine subjects
merged_data <- cbind(Subject, Y, X)  # Merge all into one dataset

# STEP 3: Extract only mean and standard deviation columns --------------------

tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

# STEP 4: Replace activity codes with descriptive activity names --------------

tidy_data$code <- activities[tidy_data$code, 2]
names(tidy_data)[2] <- "activity"

# STEP 5: Rename variable names with descriptive names ------------------------

names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# STEP 6: Create a tidy dataset with the average of each variable -------------
# for each activity and each subject

final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# STEP 7: Write the final tidy dataset to a text file -------------------------

write.table(final_data, "tidy_dataset.txt", row.name = FALSE)

# Done! ----------------------------------------------------------------------
cat("Tidy dataset created and saved as 'tidy_dataset.txt' in your working directory.\n")

