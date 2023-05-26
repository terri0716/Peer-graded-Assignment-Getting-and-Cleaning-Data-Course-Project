## Preparing data
# Download and unzip file
fileName <- "project_data_folder"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, fileName, method="curl")
unzip(fileName)

# Reading tables
folderName <- "UCI HAR Dataset"
features <- read.table(paste(folderName,"/features.txt",sep=""))
activities <- read.table(paste(folderName,"/activity_labels.txt",sep=""))
X_train <- read.table(paste(folderName,"/train/X_train.txt",sep=""))
y_train <- read.table(paste(folderName,"/train/y_train.txt",sep=""))
X_test <- read.table(paste(folderName,"/test/X_test.txt",sep=""))
y_test <- read.table(paste(folderName,"/test/y_test.txt",sep=""))
subject_train <- read.table(paste(folderName,"/train/subject_train.txt",sep=""))
subject_test <- read.table(paste(folderName,"/test/subject_test.txt",sep=""))
# Assigning table column names tables
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]
colnames(y_train) <- "activity_label"
colnames(y_test) <- "activity_label"
colnames(subject_train) <- "subject_label"
colnames(subject_test) <- "subject_label"
colnames(activities) <- c("activity_label", "activity")

## 1. Merge the training & test sets to create 1 data set
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data = cbind(subject, y, X) #merge by subject, activity, features

## 2. Extract only the measurements on the mean and standard deviation for each measurement
extracted_data <- select(merged_data, subject_label, activity_label, contains("mean"), contains("std"))

## 3. Use descriptive activity names to name the activities in the data set
extracted_data$activity_label <- activities[extracted_data$activity_label, 2]

## 4. Appropriately label the data set with descriptive variable names
# - Using information from the features selection text file, 
#   we can expand some abbreviations of some feature column names to be more descriptive 
colnames(extracted_data) <- gsub("Acc", "Accelerometer", colnames(extracted_data))
colnames(extracted_data) <- gsub("Gyro","Gyroscope", colnames(extracted_data))
colnames(extracted_data) <- gsub("^t", "Time", colnames(extracted_data))
colnames(extracted_data) <- gsub("^f", "FrequencyDomain", colnames(extracted_data))

## 5. From the data set in step 4, create a 2nd, independent tidy data set with
##    the average of each variable for each activity and each subject
data2 <- aggregate(. ~subject_label + activity_label, extracted_data, mean)
data2 <- data2[order(data2$subject_label, data2$activity_label),]
write.table(data2, "final_data.txt", row.name=FALSE)
