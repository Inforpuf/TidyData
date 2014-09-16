TidyData
========

Project of Getting and Cleaning Data course

How it works:

First the zip is downloaded into the working directory.
Second the values for the experiment and the column names are unzipped and joined together into a variable called DATA.
Third the column with mean and std in its name are selected (mean_col std_col) and joined together (selected_cols), but only the first six columns are selected in order to been capable to read at a glimpse the results (selectedData).
Fourth a new column is attached to selectedData, it has the names of the activities considered in the experiment.
Fifth labels the data set with descriptive variable names that also will make it possible to been used in functions like summarize().
Sixth create an independent, tidy data set with the average of each variable for each activity and each subject.
And finally write the data set to a archive called solution.txt. The data is saved with sep="\t", ######in order to read the file the comand read.write("result.txt", sep="\t",row.name=FALSE)
