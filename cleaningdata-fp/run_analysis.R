#Load the needed libraries, and files
library('dplyr')
source('get_col_from_file.R')
source('get_activity_name.R')

#Read training set into train_df
train_df <- read.table('train/X_train.txt')

#Read test set into test_df
test_df <- read.table('test/X_test.txt')

#Get the feature names
features <- c()
for(line in readLines('features.txt')){
    features <- cbind(features, line)
}

#Assign features to colnames for training set
colnames(train_df) <- features

#Assign features to colnames for training set
colnames(test_df) <- features

#Take a fast look at what our data look like.
View(head(train_df))

#Let's get the subjects for each observation, 
train_df <- get_col_from_file(train_df, file_path='train/subject_train.txt', 
                                  colnames=c('subject'), header=FALSE,
                                  where_to_bind='beginning')

#Do the same thing to the test set
test_df <- get_col_from_file(test_df, file_path='test/subject_test.txt', 
                                  colnames=c('subject'), header=FALSE,
                                  where_to_bind='beginning')

#Now let's add the labels the same we added subjects.
train_df <- get_col_from_file(train_df, file_path='train/y_train.txt', 
                                   colnames=c('activity'), header=FALSE)
test_df <- get_col_from_file(test_df, file_path='test/y_test.txt', 
                                   colnames=c('activity'), header=FALSE)

#Take another fast look
View(head(train_df))

#Join train and test sets
full_df <- rbind(train_df, test_df)

#Check dimensions of full_df to see if all went well.
if(dim(full_df)[1] != (dim(test_df)[1] + dim(train_df)[1])){
    stop("Something went wrong with the binding.")
}

#Add a column, call it activitynames, which is the name of the activity
full_df <- mutate(full_df, activityname = as.character(get_activity_name(activity)))

#Transform full_df into tbl_df
full_df <- tbl_df(full_df)

#Take a fast look at our activity names column to make sure it is correct
View(sample(select(full_df, activity, activityname)))

#Define patterns of columns that we want to keep
to_keep <- "mean|subject|activity|std"

#Select only columns of full_df that we want
full_df <- select(full_df, grep(to_keep, colnames(full_df)))

#Set up patterns to remove -X -Y and -Z columns
to_remove <- "-X|-Y|-Z|-meanFreq"

#Select only columns of full_df that we want
full_df <- select(full_df, -grep(to_remove, colnames(full_df)))

#Set up clean column names
clean_col_names <- c('subject', 'mnbodyacc', 'snbodyacc', 'mngravityacc', 
                     'sngravityacc', 'mnbodyaccwjerk', 'snbodyaccwjerk', 
                     'mnbodygyro', 'snbodygyro', 'mnbodygyrowjerk', 
                     'snbodygyrowjerk', 'fmnbodyacc', 'fsnbodyacc', 
                     'fmnbodyaccwjerk', 'fsnbodyaccwjerk', 'mnfbodygyro', 
                     'snfbodygyro', 'mnfbodygyrowjerk', 'snfbodygyrowjerk', 
                     'activity', 'activityname')
#Set the column names of full_df
colnames(full_df) <- clean_col_names

#Chain commands on full_df, group by subject, and activity id, 
#and activityname (just for R not to calculate its mean), then use summarise_all
#to summarize all columns by the groups, run mean as function with na.rm = true
full_df_grouped <- full_df %>%
    group_by(subject, activity, activityname) %>%
    summarise_all(funs(mean(., na.rm=TRUE)))

#Take a look at the resulting dataframe
View(full_df_grouped)

#Write the dataframe to csv file
write.csv(full_df_grouped, file = "tidydata.csv")

