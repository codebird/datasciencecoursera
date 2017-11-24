## Data
Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Steps taken to clean and tidy the data:
- Load the needed libraries, and files
- Read training set (train/X_train.txt) into train_df using read.table
- Read test set into (test/X_test.txt) test_df using read.table
- Read lines of file features.txt to get the feature names
- Update column names of train_df using the feature names list above
- Update column names of test_df using the feature names list above
- Read train set subjects (train/subject_train.txt) 
- Set the column name of this df to subject
- Merge this new dataframe to train_df at the beginning using cbind
- Repeat those 3 steps to merge test subjects (test/subject_test.txt) to test_df
- Repeat those 3 steps to merge train activities (train/y_train) to train_df, 
the only difference is that we'll be merging to the end of train_df 
- Repeat those 3 steps to merge test activities (test/y_test) to test_df, 
the only difference is that we'll be merging to the end of test_df
- Use rbind to bind together train_df and test_df
- Read activities file (activity_labels.txt) to get to know what number stands for what activity
- Use the data we just read to create a new column in the merged dataframe which
will contain the name of the activity not its number.
- Transform the merged df full_df to a table dataframe using tbl_df
- Set up patterns of the column names you want to keep, "mean|subject|activity|std"
so any column containing any of these words
- Select only these columns using Select function, and overwrite full_df
- Set up patterns of the column names you want to remove "-X|-Y|-Z|-meanFreq"
so any column containing any of these patterns will be removed
- Select all columns minus the columns that match the above patterns.
- Create a new collection containing 21 strings which are the new tidy column names
of the 21 columns remaining in our full_df
- Update colnams of full_df with the above collection
- Chain commands on full_df, group by subject, and activity id, and activityname 
(just for R not to calculate its mean), then use summarise_all to summarize all 
columns by the groups, run mean as function with na.rm = true
- Write full_df_grouped to csv file called tidy.csv

## Variables
### Any variable that starts with mn is mean normalized
### Any variable that starts with sn is std normalized
- subject: the id of the subject that the observation is about
- activity: the id of the activity being performed
- activityname: the name of the activity being performed.
- mnbodyacc: mean normalized body acceleration
- snbodyacc: std normalized body acceleration
- mngravityacc: mean normalized gravity acceleration
- sngravityacc: std normalized gravity acceleration
- mnbodyaccwjerk: mean normalized body acceleration with jerking
- snbodyaccwjerk: std normalized body acceleration with jerking
- mnbodygyro: mean normalized body from gyro sensor
- snbodygyro: std normalized body from gyro sensor
- mnbodygyrowjerk: mean normalized body from gyro sensor with jerk
- snbodygyrowjerk: std normalized body from gyro sensor with jerk
- fmnbodyacc: FFT mean normalized body acceleration
- fsnbodyacc: FFT std normalized body acceleration
- fmnbodyaccwjerk: FFT mean normalized body acceleration with jerk
- fsnbodyaccwjerk: FFT std normalized body acceleration with jerk
- mnfbodygyro: FFT mean normalized body from gyro sensor
- snfbodygyro: FFT std normalized body from gyro sensor
- mnfbodygyrowjerk: FFT mean normalized body from gyro sensor with jerk
- snfbodygyrowjerk: FFT std normalized body from gyro sensor with jerk