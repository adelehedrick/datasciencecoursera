if (!file.exists("getdata_data_ss06hid.csv")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
      destfile = "./getdata_data_ss06hid.csv", method = "curl")
}

list.files("./")

house_data <- read.table("./getdata_data_ss06hid.csv", sep=",", header = TRUE)
head(house_data)

# the properties that are 1 million or higher value, have the VAL column set to 24
props_1m <- house_data[which(house_data["VAL"] == 24), c("VAL")]
length(props_1m)

# answer is 53 (correct)

# Question 2: Use the data you loaded from Question 1. Consider the variable FES in the code book.
# Which of the "tidy data" principles does this variable violate? 
# Tidy data has one variable per column (CORRECT) 

if (!file.exists("getdata_data_DATA.gov_NGAP.xlsx")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", 
                destfile = "./getdata_data_DATA.gov_NGAP.xlsx", method = "curl")
}

library("xlsx")
gas_data <- read.xlsx("./getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1, header=TRUE, colIndex=7:15, rowIndex=18:23)

sum(gas_data$Zip*gas_data$Ext,na.rm=T)

# answer is 36534720 (correct)

library("XML")
file_url <- "./getdata_data_restaurants.xml"
doc <- xmlTreeParse(file_url, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
spec_zip <- zipcodes[zipcodes=="21231"]
length(zipcodes)
length(spec_zip)

# answer is 127 (correct)

#5: tapply                      INCORRECT
#5: mean(DT$pwgtp15,by=DT$SEX)  INCORRECT

# getdata_data_ss06pid.csv
library("data.table")
#DT <- tempfile()
DT <- read.table("./getdata_data_ss06pid.csv", sep=",", header = TRUE)
#write.table(house_data, DT, row.names=FALSE, col.names=TRUE, sep=",")
#system.time(fread(DT))
head(DT)

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])


