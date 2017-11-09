rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data = read.csv('outcome-of-care-measures.csv', colClasses = "character")
    ## Check that state and outcome are valid
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
    
    ## drop NAs
    data <- data[!is.na(data[2]), ]
    
    ## order data by lowest outcome, and then alphabetically
    data <- with(data,  data[order(data[2], data[1]) , ])
    data['rank'] <- rank(data[2])
    ## Process num
    ## Fix num to make it integer
    if(is.character(num)){
        if(num == "best"){
            num <- 1;
        }
        else if(num == "worst") {
            num <- nrow(data);
        }
    }
    num <- as.integer(num)
    ## Check if num is greater than data rows, return NA
    if(num > nrow(data)){
        return(NA)
    }
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    data[num, 'Hospital.Name']
}