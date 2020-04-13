## Step1-Creating a folder and downloading the file folder from the given URL

filename <- "Coursera_Week4_Assessment"

# Checking if file exists, else download using download.file() from the URL, and give it a filename.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists, if yes, unzip the contents
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}
## Step3- Creating tables for each file in the dataset except the file with the name _info
## There are 8 txt files to create tables, and the column names are also provided for easier representation

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("number","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity", "activity_name"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")


## Step4- Merging the rows of subject tables for test and train
## Step5- Merging the rows of test and train for X and Y respectively

data <- rbind(x_train, x_test)
subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
Merge_all <- cbind(subject, data, activity)

## call the library function for dplyr

library(dplyr)

## Looking into the dimentions and the few rows of the table

head(Merge_all)
dim(Merge_all)


## Step9- We need data from the table which contains the column names with "mean" and "Std"
## Using the chain function here

Extract <- Merge_all %>% select(subject, activity, contains("mean"), contains("std"))

## Step10- Assigning the descriptive activity names

names(Extract)

## By looking at the names of the extract data, we can infer the changes to be made
## Acc can be replaced with Accelerometer
## Gyro can be replaced with Gyroscope
## BodyBody can be replaced with Body
## Mag can be replaced with Magnitude
## Character f can be replaced with Frequency
## Character t can be replaced with Time

names(Extract)<-gsub("Acc", "Accelerometer", names(Extract))
names(Extract)<-gsub("Gyro", "Gyroscope", names(Extract))
names(Extract)<-gsub("BodyBody", "Body", names(Extract))
names(Extract)<-gsub("Mag", "Magnitude", names(Extract))
names(Extract)<-gsub("^t", "Time", names(Extract))
names(Extract)<-gsub("^f", "Frequency", names(Extract))

## Checking the names after making changes

names(Extract)
