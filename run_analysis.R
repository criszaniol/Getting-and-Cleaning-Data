### run_analysis.R ### 

#load packages
library(dplyr)
library(tidyr)

#Merges the training and the test sets to create one data set.

#Read files
t.name<-read.table('./UCI HAR Dataset/features.txt')
feature<-t.name[,2]

#test
test.subj<-read.table('./UCI HAR Dataset/test/subject_test.txt',col.names='SubjectID')
test.X<-read.table('./UCI HAR Dataset/test/X_test.txt',col.names=t.name[,2])
test.y<-read.table('./UCI HAR Dataset/test/y_test.txt',col.names='Activity')
#Descriptive activity names 
  test.y[test.y=='1',]<-'WALKING'
  test.y[test.y=='2',]<-'WALKING_UPSTAIRS'
  test.y[test.y=='3',]<-'WALKING_DOWNSTAIRS'
  test.y[test.y=='4',]<-'SITTING'
  test.y[test.y=='5',]<-'STANDING'
  test.y[test.y=='6',]<-'LAYING'
#Bind test data
data_test<-cbind(test.subj,(cbind(test.y,test.X)))

#train
train.subj<-read.table('./UCI HAR Dataset/train/subject_train.txt',col.names='SubjectID')
train.X<-read.table('./UCI HAR Dataset/train/X_train.txt',col.names=t.name[,2])
train.y<-read.table('./UCI HAR Dataset/train/y_train.txt',col.names='Activity')
#Descriptive activity names
  train.y[train.y=='1',]<-'WALKING'
  train.y[train.y=='2',]<-'WALKING_UPSTAIRS'
  train.y[train.y=='3',]<-'WALKING_DOWNSTAIRS'
  train.y[train.y=='4',]<-'SITTING'
  train.y[train.y=='5',]<-'STANDING'
  train.y[train.y=='6',]<-'LAYING'
#Bind train data
data_train<-cbind(train.subj,(cbind(train.y,train.X)))

#Remove auxiliary variables 
rm(test.subj,train.subj,test.X,test.y,train.X,train.y)

#Join data from test and train 
data<-rbind(data_test,data_train)
 
#Extracts only the measurements on the mean and standard deviation for each measurement. 
select_data<-select(data,SubjectID,Activity,contains('.std.'),contains('.mean.'))


#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
new_data<-gather(select_data,feature,value,everything(),-Activity,-SubjectID)
new_data<-group_by(new_data,feature,SubjectID,Activity)
new_data<-summarize(new_data,Averages=mean(value))
write.table(new_data,file='new_data.txt',row.name=FALSE)



