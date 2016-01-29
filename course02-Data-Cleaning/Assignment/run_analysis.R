library(RCurl)
library(reshape2)

# Download the data if neccessary 
filename <- "getdata_projectfiles_UCI_HAR_dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])

# Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
f <- grep(".*mean.*|.*std.*", features[,2])
f.names <- features[f,2]
f.names = gsub('-mean', 'Mean', f.names)  # take out the dash and capitalize
f.names = gsub('-std', 'Std', f.names)    # take out the dash and capitalize 
f.names <- gsub('[-()]', '', f.names)     # Remove excess characters

# Load training set filtered by the features, f, that we want
train <- read.table("UCI HAR Dataset/train/X_train.txt")[f]
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

# load test set filtered by the features, f, that we want
test <- read.table("UCI HAR Dataset/test/X_test.txt")[f]
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge the training and test set and add the column names
merged_data <- rbind(train, test)
colnames(merged_data) <- c("subject", "activity", f.names)

# convert activities and subjects into factors
merged_data$activity <- factor(merged_data$activity, levels = activities[,1], labels = activities[,2])
merged_data$subject <- as.factor(merged_data$subject)

# get the mean of each variable for each subject-activity
merged_data_melted <- melt(merged_data, id = c("subject", "activity"))
tidy_data <- dcast(merged_data_melted, subject + activity ~ variable, mean)

write.table(tidy_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)
