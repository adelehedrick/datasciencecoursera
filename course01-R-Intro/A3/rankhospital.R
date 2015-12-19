rankhospital <- function(state, outcome, num = "best") {
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
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    # select specific data and clear out the NAs
    data <- data[which(data[7] == state[1] & data[out_col[1]] != "Not Available"), c(2, out_col[1])]
    data[[2]] <- as.numeric(data[[2]])
    
    # order by hospital name
    data <- data[order(data[1], na.last = TRUE, decreasing = FALSE),]
    
    # rank by outcome and ties are resolved by their order (alphabetical)
    rank <- rank(data[2], ties.method = "first")
    
    # add the ranking to the data frame and order by rank
    data <- cbind(data, rank)
    data <- data[order(data[3], na.last = TRUE, decreasing = FALSE),]
    
    if (num == "best")
        result <- data[1,1]
    else if (num == "worst") {
        result <- tail(data,1)
        result <- result[1,1]
    } else if (is.numeric(num[1]))
        result <- data[num[1],1]
    
    result[1]
}