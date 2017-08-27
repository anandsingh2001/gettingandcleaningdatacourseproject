library(dplyr)
library(reshape2)

filename <- "dataset.zip"
# Download and unzip the dataset
if (!file.exists(filename)){
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileurl, filename, mode = "wb")
}
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}

# Read training datasets
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subjecttrain, ytrain, xtrain)

# Read test datasets
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subjecttest, ytest, xtest)

# Read feature vector
features <- read.table('./UCI HAR Dataset/features.txt')

# Read activity labels and apply column names
activitylabels = read.table('./UCI HAR Dataset/activity_labels.txt')
colnames(activitylabels) <- c('activityid','activitytype')

# Merge Train and Test datasets
all <- rbind(train, test)
colnames(all) <- c("subjectid", "activityid", as.character(features[,2]))

# Select mean and std columns
cols <- colnames(all)
wantedcols <- grepl("subject*|activity*|mean|std", cols)
withmeanstd <- all[, wantedcols == TRUE]

# Merge activity labels
withactivitylabels <- merge(activitylabels, withmeanstd, by = "activityid", all.X = TRUE)

#Sort rows by subjectid column
withactivitylabels <- withactivitylabels[order(withactivitylabels$subjectid, withactivitylabels$activityid),]
#Reorder columns and drop activityid column
withactivitylabels <- withactivitylabels[,c(3,2,4:82)]

# Create tidy dataset and write out to file
withactivitylabels <- melt(withactivitylabels, id = c("subjectid", "activitytype"))
tidydata <- dcast(withactivitylabels, subjectid + activitytype ~ variable, mean)
write.table(tidydata, "tidydata.txt", row.names = FALSE, quote = FALSE)
