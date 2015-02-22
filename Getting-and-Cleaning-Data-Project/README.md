# Getting and Cleaning Data

## Course Project

This repository is hosting the R code for the assignment of the DataScience track's "Getting and Cleaning Data".

The purpose of this project is to demonstrate the collection, work with, and cleaning of this data set. Tidy data have been prepared so can be used for later analysis.

R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data source and put into a folder on your local drive e.g.'Project'. You'll have a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```. 
3. Run ```source("run_analysis.R")```, then it will generate a new file ```tidy_Data.txt``` in folder ```mergedata``` inside the ```UCI HAR Dataset```.         

 working directory.                                                    
 Folder Structure say inside folder 'Project' will have these file and folder:      
 - *run_analysis.R                                                     
 - *UCI HAR Dataset/

4. A codebook is available in the repository and is named CodeBook.md.


## Dependencies

```run_analysis.R``` file uses library. It depends on ```reshape2``` and ```dplyr```. 
