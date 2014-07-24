

#Point 0 of project. Merges the training and the test sets to create one data set.
loadData<-function(){
  dsubjecttrain <<- fread("./train/subject_train.txt")
  dYTrain <<- fread("./train/y_train.txt")
  dXTrain <<-  data.table(read.table("./train/X_train.txt"))
 
  dsubjecttest <<- fread("./test/subject_test.txt")
  dYTest <<- fread("./test/y_test.txt")
  dXTest <<- data.table(read.table("./test/X_test.txt"))
}

#Point 1 of project. Extracts only the measurements on the mean and standard deviation for each measurement. 
mergeData<-function(){
  subject<-rbind(dsubjecttrain, dsubjecttest)
  y<- rbind(dYTrain, dYTest)
  x<- rbind(dXTrain, dXTest)
  dmerged<<- cbind( subject,y,x ) 
  names(dmerged)[1]<<- "subject"
  names(dmerged)[2]<<- "activity"

}


#Point 2 of project. Extracts only the measurements on the mean and standard deviation for each measurement. 
# the () is included in grep to catch mean() and std() but not gravityMean or meanFreq (which are means but not measures meant)
meanAndSD<-function(){
  features <- fread("./features.txt")
  indexes<-sort(c(grep("mean\\(\\)", features$V2),grep("std\\(\\)", features$V2)))
  featuresNames<- paste0("V", indexes)
  featuresDescriptiveNames<<-features[indexes]$V2
  dMeanAndSD<<-subset(dmerged, select = c("activity","subject",featuresNames))
}

#Point 3 of project. Uses descriptive activity names to name the activities in the data set
descriptiveActivityNames<-function(){
  activitynames <- fread("activity_labels.txt")
  names(activitynames)[1]<-"activity"
  names(activitynames)[2]<-"activityName"
  dmergedWithActivityNames <<- merge(activitynames, dMeanAndSD,  by = "activity", all.x = TRUE)
}

#Point 4 of project. Appropriately labels the data set with descriptive variable names. 
descriptiveVariableNames<-function(){
  d<-dmergedWithActivityNames
  a<- featuresDescriptiveNames
  a<- sub("\\(\\)", "", a)
  a<- sub("-", ".", a)
  names(d)[4:length(names(d))]<-a 
  dWithDescriptiveVariableNames<<-d

}


#Pont 5 of project. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
secondTidyDataSet<-function(){
  d<-dWithDescriptiveVariableNames
  activities<- unique(d$activityName)
  subjects<- unique(d$subject)
  numericalVariables<-names(d)[4:length(names(d))]

  dtidy<<-data.frame()
  for (i in 1:length(activities)){
    for (j in 1:length(subjects)){  
      daux<- subset(d, activityName==activities[i] & subject==subjects[j])
      activityName<-activities[i]
      subject<-subjects[j]
      
      daux2<- colMeans(subset(daux,select=numericalVariables))
     
      daux3<-data.frame(rbind(daux2))

      daux4<-cbind(activityName,subject, daux3 )
      dtidy <<- rbind(dtidy, daux4)
 
    }    
  }
  write.csv(dtidy, file = "tidyData.csv",row.names=FALSE)
 
}

require("data.table")
loadData()
mergeData()
meanAndSD()
descriptiveActivityNames()
descriptiveVariableNames()
secondTidyDataSet()



