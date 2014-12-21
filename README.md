---
title: "README"
author: "Czaniol"
date: "21-12-2014"
output: html_document
---

### Introduction

The script was created in RStudio Version 0.98.1087 – © 2009-2014, R version 3.1.2, on Linux. It required 'dplyr' and 'tidyr' packages. To run the script, set as workspace the folder with run_analysis.R and UCI HAR Dataset folder, and source it.

### Description 

The dataset includes the following files:

- 'README.md'

- 'CodeBook.md': Shows information about tidying data.

- 'run_analysis.R': Script to generate 'new_data.txt'.

- 'new_data.txt': data with 4 variables ('feature','SubjectID','Activity','Averages') and 11880 observations related to raw data in 'features.txt'.

### Procedures

The script 'run_analysis.R' uses 'dplyr' and 'tidyr' packages.

#### Read files
It had been used read.table() to read the files, whit option col.names='' to generate header:

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

### Notes
- More detail can be acquired in [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

- The [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) could be acquired in the previous link.




