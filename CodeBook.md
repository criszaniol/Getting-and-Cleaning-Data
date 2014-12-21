
# "Codebook - Course Project"
###### author: "Czaniol"
###### date: "21-12-2014"

### Data

The data is based in a experiment with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone which captures, by accelerometer and gyroscope tools, accelaration and angular velocity on 3D. Detail information in [Human Activity Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been partitioned into two sets, where 70% of the volunteers was selected for generaating the training data and 30% the test data. The original data has 563 variables (raw signals tAcc-XYZ, tGyro-XYZ,tBody-XYZ,tGravityAcc-XYZ,etc) and 10299 observations from 30 volunteers.
  

### Variables

The dataset was obtained binding raw data, first for test and train files by columns, and, second, by rows, for test and train dataset. After that, we extracted only the meadurements on the mean and standard deviation (ie., variables description with '-mean()','-sdt()').

The activities, inicially described with numbers, has been changed for the descriptions: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

From this dataset, the new dataset was created relating variables with subject and activity by variable mean of each feature describe below:

 - tBodyAcc-XYZ

- tGravityAcc-XYZ

- tBodyAccJerk-XYZ

- tBodyGyro-XYZ

- tBodyGyroJerk-XYZ

- tBodyAccMag

- tGravityAccMag

- tBodyAccJerkMag

- tBodyGyroMag

- tBodyGyroJerkMag

- fBodyAcc-XYZ

- fBodyAccJerk-XYZ

- fBodyGyro-XYZ

- fBodyAccMag

- fBodyAccJerkMag

- fBodyGyroMag

- fBodyGyroJerkMag

### Procedures

The script 'run_analysis.R' uses 'dplyr' and 'tidyr' packages.

#### Read files
It had been used readtable() to read the files, whit option col.names='' to generate header:

- 'subject_test.txt','X_test.txt', 'y_test.txt'

- 'subject_train.txt','X_train.txt', 'y_train.txt'

The names of 'X_test.txt' and 'X_train.txt' was attribute by the reading of 'features.txt'.
With the reading of 'y_test.txt' and 'y_train.txt, it was changed the value of variables from 'activity_labels.txt':

- 1 WALKING

- 2 WALKING_UPSTAIRS

- 3 WALKING_DOWNSTAIRS

- 4 SITTING

- 5 STANDING

- 6 LAYING

To merge all data, the function cbind was used. To join test and train data, rbind was used.

#### Extracts 'mean' and 'standard deviation' for each measurement

We are interested just in the variables which describes mean and standard deviation, then we use the select() from 'dplyr' package. The new dataset, 'select_data', has as variables: SubjectID, Activity and features with '.std.' and '.mean.'. The command used is:

```{r}
select_data<-select(data,SubjectID,Activity,contains('.std.'),contains('.mean.'))
```


#### Creating a second tidy dataset

We want to show the average of each variable for each activity and each subject, so we use 'tidyr' package. We need to be able to group the data by features - for that, we use gather to takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed,

```{r}
new_data<-gather(select_data,feature,value,everything(),-Activity,-SubjectID)
```

So, we group the new_data,

```{r}
new_data<-group_by(new_data,feature,SubjectID,Activity)
```

and we create a new_data, which permits see some characteristic desired. In this case, we summarize using mean on value refering to feature.

```{r}
new_data<-summarize(new_data,Averages=mean(value))
```

Finally, we write a new file with the tidy data.

```{r}
write.table(new_data,file='new_data.txt',row.name=FALSE)n.'))
```






