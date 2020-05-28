setwd("UCI HAR Dataset")
attribute<- read.table("features.txt", sep="")
attribute<- attribute[,2]
label<- read.table("activity_labels.txt", sep="")
label<- label[,2]

xtest<- read.table("test/X_test.txt", sep="")
names(xtest)<- attribute
ytest<- read.table("test/y_test.txt", sep="")
names(ytest)<- "activity"
ytest$activity<- as.factor(ytest$activity)
levels(ytest$activity)<- label
testsubject<- read.table("test/subject_test.txt", sep="")
names(testsubject)<- "subject"
testsubject$subject<- as.factor(testsubject$subject)
test<- cbind(xtest,testsubject,ytest)


xtrain<- read.table("train/X_train.txt", sep="")
names(xtrain)<- attribute
ytrain<- read.table("train/y_train.txt", sep="")
names(ytrain)<- "activity"
ytrain$activity<- as.factor(ytrain$activity)
levels(ytrain$activity)<- label
trainsubject<- read.table("train/subject_train.txt", sep="")
names(trainsubject)<- "subject"
trainsubject$subject<- as.factor(trainsubject$subject)
train<- cbind(xtrain,trainsubject,ytrain)

testtrain<- rbind(test,train) ## Combined test and train datasets.
name<- names(testtrain)
l1<- grep("mean()", name)
l2<- grep("std()", name)

l<- c(l1,l2, 562,563)
stdandmean<- testtrain[l] ## dataframe with mean and standard deviations extracted.

tidydata <- aggregate(.~subject + activity,stdandmean,function(x=colnames(testtrain)) mean(x)) ## average of each variable for each activity and subject.





