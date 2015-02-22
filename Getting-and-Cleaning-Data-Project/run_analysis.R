##
## Getting-and-Cleaning-Data-Project. By bintu.vasudevan@gmail.com
##
## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## Folder Structure say inside folder 'Project' will have these:
## |
## |---run_analysis.R
## |
## |---UCI HAR Dataset/
##

# Go into folder 'UCI HAR Dataset'
setwd("UCI HAR Dataset/")

# First clear the R environment
rm(list=ls(all=TRUE))

#Load requiered library
library(dplyr)
library(reshape2)

#Read 'features.txt' file
features = read.table("features.txt", header = FALSE)   
featureName = features[,2]

#Select only the relevent features (contain 'mean' and 'std') inorder 
#as it appears in 'features.txt' and just take the Index and the features Names.
featureIndex_MeanStd = grep(".*[Mm]ean.*|.*[Ss]td.*", featureName, perl=TRUE)
featureName_MeanStd = grep(".*[Mm]ean.*|.*[Ss]td.*", featureName, perl=TRUE,value=TRUE)

# Rename the features to add as header in tidy data such that R can read 
# it properly. Basically exclude special characters like {(),-}.
featureName_MeanStd = gsub("[(),]","",featureName_MeanStd)
featureName_MeanStd = gsub("-","_",featureName_MeanStd)

#This clean 'featureName_MeanStd' is required to put in the codeBook commnt after writing it once.
#write.table(featureName_MeanStd, file="featureName_MeanStdFilter.txt",quote = FALSE,row.names = FALSE)

#Read 'activity_labels.txt' file
activity_labels = read.table("activity_labels.txt", header = FALSE)   
#activity_labels[1,2]

# Read train data, 'subject_train', 'X_train' and 'y_train' files.
subject_train = read.table("./train/subject_train.txt", header = FALSE)                             
x_train = read.table("./train/X_train.txt", header = FALSE)                             
y_train = read.table("./train/Y_train.txt", header = FALSE)                             

#Combined train data with 'subject_train', 'y_train' and selected 
#columns from 'X_train' files to filter only data for the selected features 
#use the index of those features to select data
train_MeanStd_Field = select(x_train,featureIndex_MeanStd)

#cbind train data with {'Suject_ID', 'Activity_Name', 'Data of selected features'}
train_MergeData = cbind(subject_train$V1,activity_labels[y_train$V1,2],train_MeanStd_Field)

#Add  headder to the new train mearged data
names(train_MergeData)<-c("Subject_ID","Activity_Name",featureName_MeanStd)
#head(train_MergeData)


# Read test data, 'subject_test', 'X_test' and 'y_test' files.
subject_test = read.table("./test/subject_test.txt", header = FALSE)                             
x_test = read.table("./test/X_test.txt", header = FALSE)                             
y_test = read.table("./test/Y_test.txt", header = FALSE)      

#Combined test data with 'subject_test', 'y_test' and selected 
#columns from 'X_test' files to Select only data for the selected features 
#use the index of those features to select data
test_MeanStd_Fields = select(x_test,featureIndex_MeanStd)

#cbind test data with {'Suject_ID', 'Activity_Name', 'Data of selected features'}
test_MergeData = cbind(subject_test$V1,activity_labels[y_test$V1,2],test_MeanStd_Fields)

#Add  headder to the new test mearged data
names(test_MergeData)<-c("Subject_ID","Activity_Name", featureName_MeanStd)
#head(test_MergeData)


#Mearge Training and Test data into one variable say MergedAllData
mergedAllData = rbind(train_MergeData,test_MergeData)
#head(mergedAllData)

# free some memory by removing un-used bigger data set (x_test, x_train) 
rm(x_test);rm(x_train)

# Wrtie the data file into single data set say MergedAllData
# which has 'Subject_ID', 'Activity_Name', 
# and 86 fields which is either mean or std measurement. 

# if Needed write MergedAllData into folder 'mergeddata' 
#if folder 'mergedata' doesn't exist, create it and write data
if (!file.exists("./mergedata")){
        dir.create("./mergedata")
}
#write.table(mergedAllData, file="./mergedata/mergedTestandTrainTidyData.txt",quote = FALSE,row.names = FALSE)
#AllData = read.table("./mergedata/mergedTestandTrainTidyData.txt", header = FALSE, row.names = FALSE)        


#Melt data frame 'mergedAllData' using 'SubjectID' and 'Activity_Name'
melted_Data <- melt(mergedAllData, id=c("Subject_ID","Activity_Name"))

#Casting data frame and get the mean for each 'Suject_ID' and 'Activity_Name' 
tidy_Data <- dcast(melted_Data, formula = Subject_ID + Activity_Name ~ variable, mean)
#head(tidy_Data)

# Write the tidy data to the folder 'mergedata'
write.table(tidy_Data, file="./mergedata/tidy_Data.txt",quote = FALSE,row.names = FALSE)

#Come out of the folder 'UCI HAR Dataset'
setwd("../")




