## R Script
```run_analysis.R``` script performs downloading the data UCI HAR Dataset and preparing of it, then transforming the data as instructed by the project. Data are stored in following variables:
* ```features``` lists all features
*```activities``` lists activity class labels with their activity name
*```X_train```, ```y_train``` training set and training labels
*```X_test```, ```y_test``` test set and test labels
*```subject_train```, ```subject_test``` identifies in the train and test set which subject performed the activity

## Data Transformations
1. Merged the training and test sets to create one data set. 
* Merged ```X_train``` with ```X_test``` to be a total ```X```, merged ```y_train``` with ```y_test``` to be a total ```y```, merged ```subject_train``` with ```subject_test``` to be a total ```subject``` then merged ```subject```, ```y```, and ```X``` to make ```merged_data```.
2. Extracted only the
measurements on the mean and standard deviation for each measurement. 
* extracted relevant data from ```merged_data``` to make ```extracted_data```.
3. Used descriptive activity names to name the activities in the data set. 
* Replaced class labels of ```activity_label``` with actual activity names from column ```activity``` in ```activities```. 
4. Appropriately labelled the data set with descriptive variable names.
* Within feature names, replaced any ```Acc``` with ```Accelerometer```, ```Gyro``` with ```Gyroscope```, leading ```t``` with ```Time```, and leading ```f``` with ```FrequencyDomain```. 
5. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject. 
* Grouped by subject and activity, took means of each variable for each activity and each subject, and summarized into ```data2```, exported as ```final_data.txt```. 
