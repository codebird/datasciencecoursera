#get_activity_name function, reads activity_labers file into a dataframe,
#then takes the activity labels from our train/test df, and sets a name for 
#each label, then it returns a list to be cbinded to our main dataframe
get_activity_name <- function (activity_ids){
    #Get activities ids and labels from activity file.
    activities_df <- read.csv('activity_labels.txt', sep=" ", header=FALSE)
    #Create an empty list
    act_names <- list()
    #for each activity id we get from the data frame, we will bind and activity
    #name to our list
    for(activity_id in activity_ids){
        act_name <- (as.character(activities_df$V2[activities_df$V1 == activity_id]))
        act_names <- rbind(act_names, act_name)
    }
    #return the filled list
    act_names
}
