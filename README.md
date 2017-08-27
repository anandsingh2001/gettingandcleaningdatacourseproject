# gettingandcleaningdatacourseproject

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

* Download the dataset if it does not already exist in the working directory and unzip it
* Read the training and test datasets, feature vector and activity labels
* Merge the training and test datasets
* Filter and keep only the mean and Std columns
* Apply the activity labels to replace the activity ids
* Sort and reorder the dataset
* Create a tidy dataset with average (mean) value of each variable for each subject and activity pair.
* Write out the end result to a file tidydata.txt.
