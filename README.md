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
And finally write the data set to a archive called solution.txt.




Code Book:
test_data: data frame that contains the data from the archive testX.txt .That data are the values used for testing
train_data: data frame that contains the data from the archive trainX.txt .That data are the values used for training
features_data: data frame that contains the data from the archive trainX.txt .That data are the names of the columns of the previous data

data: data frame that contains all data from testX.txt and trainX.txt

mean_col:boolean vector that says which column name contains "mean" on it.
std_col: boolean vector that says which column name contains "std" on it.
selected_cols: numeric vector that contains the number of the columns in mean_col or in std_col.

selectedData: data frame that contains the columns of data which number is in selected_cols.

test_act:data frame that contains the data from the archive testy.txt .That data is a number assigned to an activity.
train_act: data frame that contains the data from the archive trainy.txt .That data is a number assigned to an activity.
act_labels: data frame that contains the data from the archive activity_labels.txt . That data are the names of the activities.

aux: variable used to change the activity number present in test_act and train_act for it corresponding activity name.

act_lab: data frame that comprises the activity names for every data in seletedData and in data.

test_sub: dataframe that contains the number asigned to a subject of the experiment.
train_sub: dataframe that contains the number asigned to a subject of the experiment.
subjects: dataframe that contains all the numbers asigned to every subject of the experiment.

groupData: tbl data or data grouped by activity_label and subject, contains the same data as selectedData but divided into groups.

tidyData: tbl data that contains the average of each column taking into account the diferent activities and subjects. This data is written into an archive.