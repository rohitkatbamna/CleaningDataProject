##test
sub<-read.table("test/subject_test.txt")
testx<-read.table("test/X_test.txt")
testy<-read.table("test/y_test.txt")
fea<-read.table("features.txt")
df_test<-data.frame(testx)
colnames(df_test)<-fea$V2
df_test<-data.frame(sub,testy,df_test)
##train
sub1<-read.table("train/subject_train.txt")
trainx<-read.table("train/X_train.txt")
trainy<-read.table("train/y_train.txt")
df_train<-data.frame(trainx)
colnames(df_train)<-fea$V2
df_train<-data.frame(sub1,trainy,df_train)
###
df_all<-rbind(df_test,df_train)
colnames(df_all)[colnames(df_all) == "V1"] <- "Subject"
colnames(df_all)[colnames(df_all) == "V1.1"] <- "Activity"
library(dplyr)
df_all<-arrange(df_all,Subject,Activity)
df_all$Activity[df_all$Activity==1]<- "WALKING"
df_all$Activity[df_all$Activity==2]<- "WALKING_UPSTAIRS"
df_all$Activity[df_all$Activity==3]<- "WALKING_DOWNSTAIRS"
df_all$Activity[df_all$Activity==4]<- "SITTING"
df_all$Activity[df_all$Activity==5]<- "STANDING"
df_all$Activity[df_all$Activity==6]<- "LAYING"
###
alcol<-colnames(df_all)
library(stringr)
colm<-alcol[str_detect(alcol, "mean")]
colstd<-alcol[str_detect(alcol,"std")]
##only keep columns that are mean or std
df_all<-df_all[,c("Subject","Activity",colm,colstd)]
newall<-df_all
newall<-group_by(newall,newall$Subject,newall$Activity)
writethis<-summarize_each(newall,mean)
writethis$Subject<-NULL
writethis$Activity<-NULL
colnames(writethis)[colnames(writethis) == "`newall$Subject`"] <- "Subject"
colnames(writethis)[colnames(writethis) == "`newall$activity`"] <- "Activity"
write.table(writethis,"Odata.txt",row.names=FALSE)

