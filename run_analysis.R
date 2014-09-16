run_analysis<-function(){
	
	download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',"comprimido.zip",mode="wb")
	

	##unzip data
	test_data <- read.table(unz("comprimido.zip", "UCI HAR Dataset/test/X_test.txt"))
	train_data<- read.table(unz("comprimido.zip", "UCI HAR Dataset/train/X_train.txt"))
	features_data<- read.table(unz("comprimido.zip", "UCI HAR Dataset/features.txt"))

	##give names to the data columns
	names(train_data)<-features_data[,2]
	names(test_data)<-features_data[,2]

	##merge data
	data<-rbind(test_data,train_data)

	##Extracts only the measurements on the mean and standard deviation for each measurement. 
	##in features_data i select the columns who contain mean o std in its name
	##because i understand that it is what the instructions said
	##but in order to make the results readable i choose the first six columns of selected_cols
	##that is from tBodyAcc-mean()-X to tBodyAcc-std()-Z
	mean_col<-grepl("-mean()",features_data[,2],ignore.case=TRUE)
	std_col<-grepl("-std()",features_data[,2],ignore.case=TRUE)
	selected_cols<-c()
	for(i in 1:length(std_col)){
		if(mean_col[i]||std_col[i]){
			selected_cols<-c(selected_cols,i)
		}
	}
	selectedData<-data.frame(data[selected_cols[1]])
	##for(i in 2:length(selected_cols)){ I iniatially took all the columns selected
	for(i in 2:6){
		selectedData<-cbind(selectedData,data[selected_cols[i]])
	}

	
	##Uses descriptive activity names to name the activities in the data set
	##To know the observations' activities:
	test_act<-read.table(unz("comprimido.zip", "UCI HAR Dataset/test/y_test.txt")) ## data frame
	train_act<-read.table(unz("comprimido.zip", "UCI HAR Dataset/train/y_train.txt"))
	##first read the activities' names
	act_labels<-read.table(unz("comprimido.zip", "UCI HAR Dataset/activity_labels.txt")) ## data.frame
	##replace the numeric value for the activities' names
	aux<-test_act
	for(i in 1:nrow(act_labels)){
		aux<-apply(aux,2,gsub,pattern=i,replacement=act_labels[i,2])
	}
	test_act<-aux
	aux<-train_act
	for(i in 1:nrow(act_labels)){
		aux<-apply(aux,2,gsub,pattern=i,replacement=act_labels[i,2])
	}
	train_act<-aux
	##bind the results to match the variable data
	act_lab<-rbind(test_act,train_act)
	act_lab<-as.data.frame(act_lab)
	##and then add the activities' names to the data
	selectedData<-cbind(selectedData,act_lab)
		
	##Appropriately labels the data set with descriptive variable names.
		##Appropiately name the column with the activities
	names(selectedData)<-sub("V1","activity_label",names(selectedData))
		##delete simbols from column names in order to be correctly interpretated
	names(selectedData)<-sub("\\."," ",names(selectedData))
	names(selectedData)<-sub("\\..."," ",names(selectedData))
	names(selectedData)<-sub("-"," ",names(selectedData))
	names(selectedData)<-sub("\\("," ",names(selectedData))
	names(selectedData)<-sub("\\)"," ",names(selectedData))
	names(selectedData)<-sub("\\ ","",names(selectedData))
	names(selectedData)<-sub("\\ ","",names(selectedData))
	names(selectedData)<-sub("\\ ","",names(selectedData))
	names(selectedData)<-sub("\\ ","",names(selectedData))
	names(selectedData)<-sub("-","",names(selectedData))



	##From the data set in previous step, creates a second, independent,
	##tidy data set with the average of each variable for each activity and each subject.
	##first read the subjects
	test_sub<-read.table(unz("comprimido.zip", "UCI HAR Dataset/test/subject_test.txt"))
	train_sub<-read.table(unz("comprimido.zip","UCI HAR Dataset/train/subject_train.txt"))
	##bind that data
	subjects<-rbind(test_sub,train_sub)
	subjects<-as.data.frame(subjects)
	##add the subjects to the selected data
	selectedData<-cbind(selectedData,subjects)
	##change the name of the last column to subjects
	names(selectedData)<-sub("V1","subject",names(selectedData))
	##group by activity and subject
	groupData<-group_by(selectedData,activity_label,subject)
	tidyData<-summarize(groupData,meanOftBodyAccMeanX=mean(tBodyAccmeanX),meanOftBodyAccMeanY=mean(tBodyAccmeanY),
			meanOftBodyAccMeanZ=mean(tBodyAccmeanZ),meanOftBodyAccStdX=mean(tBodyAccstdX),
			meanOftBodyAccStdY=mean(tBodyAccstdY),meanOftBodyAccStdZ=mean(tBodyAccstdZ))
	write.table(tidyData,"result.txt",sep="\t",row.name=FALSE)
}