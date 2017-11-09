best <- function(state, outcome) {
    ## Read outcome data
    data = read.csv('outcome-of-care-measures.csv', colClasses = "character")
    ## Check that state and outcome are valid
    if(!state %in% data$State){
        stop('invalid state')
    }
    
    outcomes = list('heart attack' = 11, "heart failure" = 17, "pneumonia" = 23)
    
    if(is.null(outcomes[[outcome]])){
        stop('invalid outcome')   
    }
    
    interest_col = outcomes[[outcome]]
    
    ## Keep the state we're interested in only
    data <- data[data$State == state, c(2, interest_col)]
    
    data[, 2] <- as.numeric(data[, 2])
    
    ## Drop NAs
    data <- data[!is.na(data[2]), ]
    
    minimum <- min(data[2], na.rm = TRUE)
    data <- data[data[2] == minimum, c(1, 2)]
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    data <- with(data,  data[order(data$Hospital.Name) , ])
    data[1, 1]
    
}