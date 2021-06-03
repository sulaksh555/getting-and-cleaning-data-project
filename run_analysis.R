# Load the packages required

library(reshape2)

# Read in the dataset

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName<-"rawData.zip"
download.file(url=url, destfile=fileName)

# Unzip the zip file and place its contents in the data directory

dataDir<-"./data"

if(!file.exists(dataDir)) {
        dir.create(dataDir)
        unzip(zipfile=fileName, exdir=dataDir)
}

# Analyze the directory structure and locate the training data

xTraining<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
yTraining<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
subTraining<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# Analyze the directory structure and locate the test data

xTest<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
yTest<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
subTest<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

# Merge the previously extracted training and test sets

xDataset<-rbind(xTraining, xTest)
yDataset<-rbind(yTraining, yTest)
subDataset<-rbind(subTraining, subTest)

# Read in data about the features and activity labels

features<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/features.txt"))
actLabels<-read.table(paste(sep="", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
actLabels[, 2]<-as.character(actLabels[, 2])

# Extract measurements on the mean and standard deviation

selectColumns<-grep("-(mean|std).*", as.character(features[, 2]))
selectColumnNames<-features[selectColumns, 2]
selectColumnNames<-gsub("-mean", "Mean", selectColumnNames)
selectColumnNames<-gsub("-std", "Std", selectColumnNames)
selectColumnNames<-gsub("[-()]", "", selectColumnNames)

# Use descriptive activity names to label the activities

xDataset<-xDataset[selectColumns]
allData<-cbind(subDataset, yDataset, xDataset)
colnames(allData)<-c("Subject", "Activity", selectColumnNames)
allData$Activity<-factor(allData$Activity, levels=actLabels[, 1], labels=actLabels[, 2])
allData$Subject<-as.factor(allData$Subject)

# Create an independent, tidy data set

meltedData<-melt(allData, id=c("Subject", "Activity"))
tidyData<-dcast(meltedData, Subject+Activity~variable, mean)

# Write the dataset to a file

write.table(x=tidyData, file="./tidyData.txt", row.names=FALSE, quote=FALSE)


