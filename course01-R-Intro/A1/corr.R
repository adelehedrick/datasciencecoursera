corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  ## For this function you will need to use the 'cor' function 
  ## in R which calculates the correlation between two vectors. 
  ## Please read the help page for this function via '?cor' and 
  ## make sure that you know how to use it. 
  
  df_thresh <- complete(directory)
  df_thresh <- df_thresh[which(df_thresh[,"nobs"] >= threshold),]
  
  files <- list.files(directory, full.names = TRUE)
  df <- data.frame()
  vect_cor <- vector()
  ##df <- data.frame(dimnames=list(c(), c("id", "nobs")))
  
  for (i in df_thresh[["id"]]) {
    df_file <- read.csv(files[i])
    df_complete <- complete.cases(df_file)
    
    df <- df_file[df_complete,]
    
    vect_cor <- c(vect_cor, cor(df[["nitrate"]], df[["sulfate"]]))
    
  }
  
  vect_cor
}