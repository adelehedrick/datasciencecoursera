rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that outcome is one of
    if (outcome == "heart attack")
        out_col <- 11
    else if (outcome == "heart failure")
        out_col <- 17
    else if (outcome == "pneumonia")
        out_col <-23
    else
        stop("invalid outcome")
    
    # get list of unique states
    states <- unique(data[7])
    df <- data.frame()
    #colnames(df) <- c("hospital", "state")
    
    ## For each state, find the hospital of the given rank
    for (s in states[[1]]) {
        
        # select specific data and clear out the NAs
        state_data <- data[which(data[7] == s[1] & data[out_col[1]] != "Not Available"), c(2, out_col[1])]
        state_data[[2]] <- as.numeric(state_data[[2]])
        
        # order by hospital name
        state_data <- state_data[order(state_data[1], na.last = TRUE, decreasing = FALSE),]
        
        # rank by outcome and ties are resolved by their order (alphabetical)
        rank <- rank(state_data[2], ties.method = "first")
        
        # add the ranking to the data frame and order by rank
        state_data <- cbind(state_data, rank)
        state_data <- state_data[order(state_data[3], na.last = TRUE, decreasing = FALSE),]
        
        if (num == "best")
            result <- state_data[1,1]
        else if (num == "worst") {
            result <- tail(state_data,1)
            result <- result[1,1]
        } else if (is.numeric(num[1]))
            result <- state_data[num[1],1]
        
        #best_hospital <- rankhospital(s[1], outcome[1])
        df <- rbind(df, data.frame(hospital = result[1], state = s[1]))
    }
    
    #rownames(df) <- df[[state]]
    
    df <- df[order(df[2], na.last = TRUE, decreasing = FALSE),]
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    df
}