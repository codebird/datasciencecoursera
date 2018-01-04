rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data = read.csv('outcome-of-care-measures.csv', colClasses = "character")
    ## Check that state and outcome are valid
    ## Check that state and outcome are valid
    
    outcomes = list('heart attack' = 11, "heart failure" = 17, "pneumonia" = 23)
    
    if(is.null(outcomes[[outcome]])){
        stop('invalid outcome')   
    }
    
    interest_col = outcomes[[outcome]]
    
    ## Keep only columns of interest
    data <- data[, c(2, interest_col, 7)]
    
    data[, 2] <- as.numeric(data[, 2])
    
    ## drop NAs
    data <- data[!is.na(data[2]), ]
    
    ## order data by lowest outcome, and then alphabetically
    data <- with(data,  data[order(data[2], data[1]) , ])
    
    states = levels(as.factor(data[, 3]))
    for(s in states) {
        data[data[3] == s, 'ranks'] <- rank(data[data[3] == s, 2], ties.method = "first")
    }
    
    ## Process num
    ## Fix num to make it integer
    if(is.character(num)){
        if(num == "best"){
            num <- 1;
        }
        else {
            num <- -1;
        }
    }
    num <- as.integer(num)
    ## Check if num is greater than data rows, return NA
    if(num > max(data$rank)){
        return(NA)
    }
    
    data <- with(data,  data[order(data$rank, data$State) , ])
    colnames(data) <- c('hospital', 'deaths', 'state', 'rank') 
    if(num>0){
        data[data$rank == num, ]    
    }
    else {
        new_data = data.frame(matrix(ncol = 4, nrow=0))
        for(s in states) {
            s_subset <- subset(data, state == s)
            new_data <- rbind(new_data, s_subset[nrow(s_subset), ])
        }
        colnames(new_data) <- c('hospital', 'deaths', 'state', 'rank')
        new_data
    }
    
}