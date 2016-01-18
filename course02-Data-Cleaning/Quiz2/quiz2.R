# Q1 Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you 
# want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the 
# datasharing repo was created. What time was it created?

# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

# A: "2013-11-07T13:25:07Z"

library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "7af44a480d9d79605216",
                   secret = "416d9831939b892b64c43a0814c70a83fd6caae5")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
api_data <- content(req)

library(jsonlite)
jsonData <-fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

jsonData[which(jsonData["name"] == "datasharing"), c("created_at")]


# Q2 The sqldf package allows for execution of SQL commands on R data frames. We will use the 
# sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. 

#A sqldf("select pwgtp1 from acs where AGEP < 50")

library(RCurl)
if (!file.exists("getdata_data_ss06pid.csv")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", 
                destfile = "./getdata_data_ss06pid.csv", method = "curl")
}

acs <- read.table("./getdata_data_ss06pid.csv", sep=",", header = TRUE)
head(house_data)

library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")


#Q3 Using the same data frame you created in the previous problem, what is the equivalent 
# function to unique(acs$AGEP)

#A sqldf("select distinct AGEP from acs")


sqldf("select distinct AGEP from acs")





#Q4 How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
htmlCode
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#A 45 31 7 25

#Q5 Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

#A 28893.3 WRONG