## Getting and Cleaning Data Course Project

This is the exercise for 'Getting and Cleaning Data' Course

Instruction:

 1. Download the data to be analysed from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 1. Unzip the directory 'UCI HAR Dataset' and use it as your working directory. Alternatively, this content directory can be copied in any other working directory chosen.
 1. Copy 'run_analysis.R' to your working directory.
 1. Open R and set the working directory with ```setwd(dir)```
 1. Run the script with ```source('./run_analysis.R')```

This will create the 'tidyData.csv' file with the cleaned data besides loading the dataframe 'dtidy' in your R work space. More information about this dataset in the CodeBook.

In other words, project steps are followed automatically:

1.  Merge the training and the test sets to create one data set.
1. Extract only the measurements on the mean and standard deviation for each measurement.
1. Generate a tidy data set with the average of each variable for each activity and each subject.
1. Export this final tidy data to a 'tidyData.csv' in your working directory.