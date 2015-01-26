library(base)
library(utils)
library(reshape2)

downloadData <- function() {
    # Downloads the data that will be used in the runAnalysis() 
    # function.
    
    url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    fileName <- 'data.zip'
    
    # If the file already exists, then will not download the data.
    if (!file.exists(fileName)) 
    {
        # I did not set 'method = curl', since it doesn't work on my
        # system for whatever reason.
        download.file(url, destfile = fileName)
        unzip(fileName)
    }
    
    setwd('UCI HAR Dataset/')
}

runAnalysis <- function() {
    # It is assumed at this point that the working directory has been 
    # set to 'UCI HAR Dataset/'. If this function doesn't work, run 
    # the downloadData() function first and then run this function 
    # again.
    
    # Gets all the necessary data.
    
    testXData <- read.table(paste(getwd(), '/test/X_test.txt', sep=''))   
    trainXData <- read.table(paste(getwd(), '/train/X_train.txt', sep=''))
    testYData <- read.table(paste(getwd(), '/test/Y_test.txt', sep=''))   
    trainYData <- read.table(paste(getwd(), '/train/Y_train.txt', sep=''))
    testSubjectData <- read.table(paste(getwd(), '/test/subject_test.txt', sep=''))   
    trainSubjectData <- read.table(paste(getwd(), '/train/subject_train.txt', sep=''))
    activityLabels <- read.table(paste(getwd(), '/activity_labels.txt', sep=''))
    featureNames <- read.table(paste(getwd(), '/features.txt', sep=''))

    # Adds column names to the relevant data
    
    names(activityLabels) <- c('activityNumber', 'activityName')
    names(testXData) <- featureNames[, 2]
    names(trainXData) <- featureNames[, 2]
    names(testYData) <- "activityNumber"
    names(trainYData) <- "activityNumber"
    names(testSubjectData) <- "subject"
    names(trainSubjectData) <- "subject"
    
    # Binds all the relevant data.
    
    completeXData <- rbind(testXData, trainXData)
    completeSubjectData <- rbind(testSubjectData, trainSubjectData)
    completeYData <- rbind(testYData, trainYData)
    completeData <- cbind(completeXData, completeSubjectData, completeYData)
    
    # Merges the data such that the activity numbers are changed to their
    # respective activity names.
    
    completeData <- merge(completeData, activityLabels, by="activityNumber")
    
    # Creates descriptive variable names.
    
    columnNames <- names(completeData)
    columnNames <- gsub('-mean()', 'Mean', columnNames)
    columnNames <- gsub('-meanFreq()', 'MeanFrequency', columnNames)
    columnNames <- gsub('-std()', 'STD', columnNames)
    columnNames <- gsub('BodyBody', 'Body', columnNames)
    names(completeData) <- columnNames
        
    # Gets only the columns with the relevant terms in it.
    
    completeData <- completeData[, grep('(Mean|STD|subject|activityName)+', names(completeData))]
    
    # Creates the tidy data and writes it to a file.
    
    tidyMelt <- melt(completeData, id.vars=c('subject', 'activityName'))
    tidyData <- dcast(tidyMelt, subject + activityName ~ variable, mean)
    tidyData
}
