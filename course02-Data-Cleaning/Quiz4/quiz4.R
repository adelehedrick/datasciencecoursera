#1. 

# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value 
# of the 123 element of the resulting list?

library(RCurl)
if (!file.exists("getdata_data_ss06pid.csv")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "./getdata_data_ss06pid.csv", method = "curl")
}

house_data <- read.table("./getdata_data_ss06hid.csv", sep=",", header = TRUE)
names(house_data)

splitnames <- strsplit(names(house_data), "wgtp")
splitnames[123]

#A: "" "15"

# 2. 

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

#Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

#Original data sources:
  
#  http://data.worldbank.org/data-catalog/GDP-ranking-table 

gdp <- read.table("./getdata_data_GDP.csv", header = TRUE)

milofdol <- gdp[5]
milofdol <- milofdol[5:102,]
milofdol<-gsub(",","",milofdol)
milofdol<-gsub(" ","",milofdol)
milofdol <- as.numeric(as.character(milofdol))
mean(milofdol)
milofdol

#S 377652.4

#3 
grep("^United",gdp$X.2) #ans : 3

#4 
gdp <- read.table("./getdata_data_GDP.csv", sep = ",", skip = 4, fill= TRUE, header = TRUE)
edu <- read.table("./getdata_data_EDSTATS_Country.csv", sep = ",", fill = TRUE, header = TRUE)
mergeData <- merge(gdp, edu, by=1)
grep("June",mergeData$Special.Notes)

formattedDates <- format(sampleTimes, "%a %Y")
grep("Mon 2012", formattedDates)
sum(formattedDates == "Mon 2012")
