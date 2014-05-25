## Getting and Cleaning Data - course project

This document will help you run the code and use the output
The code assumes that the data is unzipped and is present in your working directory in the original folder structure as was present in the zipped file
The code is broken into two sections:
* Section 1 merges data from various parts
* Section 2 creates tidy data set

### Section 1 details:
* First reads activity labels and features files
* Renames features to standard R style (lower case, removes characters and uses "." as separators)
* Reads and clips together train and test datasets
* Reads and clips together train and test subject field
* Reads and clips together trains and test activity labels
* Eventually combines all data together

### Section 2 details:
* First extracts only those columns which describe mean and standard deviation of variables (excludes angle variables)
* Melts data together using subject id and activity labels
* Calculates mean for all variables over subjects and activity
* Writes tidy data to new file CourseProject.txt
