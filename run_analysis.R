## Assumes data in your working directory in the same folder structure as it is downloaded
## Run the code using run_analysis()

run_analysis <- function () {
	
	## Section 1 - Prepare comprehensive dataset
	## Read Activity labels and Features
	ActLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
	colnames(ActLabel) <- c("activitylabels", "activitynames")
	features <- read.table("./UCI HAR Dataset/features.txt")
	features <- tolower(features$V2)
	features <- gsub("-",".",features)
	features <- gsub("\\(\\)","",features)
	features <- gsub("angle\\(","angle.",features)
	features <- gsub("\\)","",features)
	features <- gsub(",",".",features)
	features <- sub("bodybody","body",features)
	
	## Read and clip together train and test datasets
	TrainValues <- read.table("./UCI HAR Dataset/train/X_train.txt")
	TestValues <- read.table("./UCI HAR Dataset/test/X_test.txt")
	AllValues <- rbind(TrainValues, TestValues)
	colnames(AllValues) <- features ## Set column names to features

	## Read and clip together Labels
	TrainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
	TestLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
	AllLabels <- rbind(TrainLabels, TestLabels)
	colnames(AllLabels) <- c("activitylabels")
	MergedAllLabels <- merge(AllLabels, ActLabel, by.x="activitylabels", by.y="activitylabels", all=TRUE)

	## Read and clip together Subjects
	SubjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
	SubjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
	AllSubject <- rbind(SubjTrain, SubjTest)
	colnames(AllSubject) <- c("subjectidentifier")

	## Combine Subject, Features and Acitivity Labels
	Alldata <- cbind(AllSubject, AllValues, MergedAllLabels)

	## Section 2 - Prepare tidy dataset 
	## Extract the dataset with variables including mean and standard deviation of all basic variables 
	stdname <- grep("std", features, value=TRUE)
	meanname <- sub("std", "mean", stdname)
	newvars <- c("subjectidentifier", meanname, stdname, "activitylabels", "activitynames")
	dataextract <- Alldata[,newvars]
	
	## Prepare tidy dataset
	library(reshape2)
	meltdata <- melt(dataextract, id.vars = c("subjectidentifier", "activitylabels", "activitynames"))
	finaldata <- dcast(meltdata, subjectidentifier + activitylabels + activitynames ~ variable, fun.aggregate = mean)
	
	## Write tidy data to new file
	write.table(finaldata, file = "CourseProject.txt")	
}
