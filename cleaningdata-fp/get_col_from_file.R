#function that takes a dataframe, then reads a file from file_path, creates a new
#data frame from that file, then binds it to the beginning or end of the data frame
#we passed to it.
get_col_from_file <- function(df, file_path, colnames, header=TRUE, where_to_bind='end'){
    new_df <- read.csv(file_path, header = header)
    
    #Update the name of the single column of the subjects
    colnames(new_df) <- colnames
    
    #Bind subjects to the train_df, subject first then the features
    #if where to bind is set to beginning
    if(where_to_bind == 'beginning'){
        df <- cbind(new_df, df)    
    }
    #Else bind to the end
    else {
        df <- cbind(df, new_df)
    }
    df
}