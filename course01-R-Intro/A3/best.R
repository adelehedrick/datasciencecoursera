best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state is valid
    if (!(state %in% data[[7]]))
        stop("invalid state") 
    
    ## Check that outcome is one of
    if (outcome == "heart attack")
        out_col <- 11
    else if (outcome == "heart failure")
        out_col <- 17
    else if (outcome == "pneumonia")
        out_col <-23
    else
        stop("invalid outcome")
    
    ## Return hospital name in that state with lowest 30-day death rate
    ## hospital name is column 2
    data <- data[which(data[7] == state[1] & data[out_col[1]] != "Not Available"), c(2, out_col[1])]
    data[[2]] <- as.numeric(data[[2]])
    data_min <- data[[2]]
    #data_min <- as.numeric(data_min)
    #data_min <- droplevels(data_min)
    data_min <- min(data[[2]])
    #data_min <- factor(data_min)
    
    data <- data[which(data[2] == data_min[1]),1]
    
    data[1]
    
    ##data <- sort(data)
    
  
    
    ##data <- drop.levels(data)
    
   
   
    
    
    
 
}

