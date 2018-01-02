#Load necessary packages.
library(dplyr)
library(readr)
library(tidyr)

#Read in headers file.
features <- read.delim("features.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)

#Read in test data.
##First, read in the subject_test and y_test files and assign column name values.
##Then, combine with the full 561 variable observations, assigning the header names previously read in to the "features" object.
testdata <- readLines("./test/subject_test.txt") %>% cbind.data.frame(as.integer(readLines("./test/y_test.txt")))
colnames(testdata) <- c("subject", "activity")
suppressMessages(suppressWarnings(
    testdata <- cbind(testdata, read_fwf("./test/X_test.txt", fwf_widths(rep(16, 561), features[,2])))
))

#Read in training data.
##First, read in the subject_test and y_test files and assign column name values.
##Then, combine with the full 561 variable observations, assigning the header names previously read in to the "features" object.
traindata <- readLines("./train/subject_train.txt") %>% cbind.data.frame(as.integer(readLines("./train/y_train.txt")))
colnames(traindata) <- c("subject", "activity")
suppressMessages(suppressWarnings(
    traindata <- cbind(traindata, read_fwf("./train/X_train.txt", fwf_widths(rep(16, 561), features[,2])))
))

#Bind the test and training tables together.
fulldata <- rbind(testdata, traindata)

#Extract the mean and standard deviation values.
##Note that for mean values we are only interested in the columns ending in mean(),
##since these are calculated from the raw signal data.
##Other mean values are derived values and not needed for this data set.
selectdata <- select(fulldata, grep("^subject$|^activity$|mean\\(\\)|std\\(\\)",names(fulldata), ignore.case = TRUE))

#Read in the activity label cross-reference.
suppressMessages(
    activityxref <- read_delim("activity_labels.txt", " ", col_names = c("activity", "activityname"))
)

#Replace the numeric activity value with the activity name.
suppressMessages(
    selectdata <- right_join(activityxref, selectdata) %>% select(-activity)
)

#Tidy up the data.

##Normalize column names using regular expressions.
##This regular expression compartmentalizes the various parts of the name and standardizes the separator to underscore.
##For "Mag" measurements, it moves the "Mag" to the end of the expression to be grouped with XYZ.
names(selectdata) <-
    sub("(.)(BodyBody|Body|Gravity)(AccJerk|Acc|GyroJerk|Gyro)(Mag)?-(mean|std)\\(\\)-?([XYZ])?",
        "\\1_\\2_\\3_\\5_\\4\\6", names(selectdata)) %>% tolower
##Expand upon these parts of the column names, since they will be used as values.
names(selectdata) <- sub("^t", "time", names(selectdata))
names(selectdata) <- sub("^f", "frequency", names(selectdata))
names(selectdata) <- sub("mag$", "magnitude", names(selectdata))

##Gather the data based on mean values, then on standard deviation values.
##Then, separate out the variables.
selectdata <- selectdata %>%
    gather(measurement, mean, contains("mean")) %>%
    gather(measurement2, standarddeviation, contains("std")) %>%
    separate(measurement, c("domainsignal", "measurement", "measurementtype", "meanstd", "direction")) %>%
    select(-c(meanstd, measurement2)) #Note: meanstd and measurement2 columns are redundant and so removed.

#Generate an independent tidy data set with the average of each variable for each activity and each subject.
meandata <- group_by(selectdata, subject, activityname, domainsignal, measurement, measurementtype, direction) %>%
    summarize(meanofmean = mean(mean), meanofstandarddeviation = mean(standarddeviation))

#Clean up temporary working objects.
rm(activityxref, features, fulldata, testdata, traindata)