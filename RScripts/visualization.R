## Visualization

### Reading data
classes<-c("integer","Date","integer",
           "integer", "double", "double", 
           "integer", "integer", "integer",
           "double", "integer", "double",
           "double", "double", "integer",
           "double", "integer", "integer",
           "integer", "integer", "integer",
           "integer", "integer", "integer", #srch_saturday_night_bool
           "double", "double", "integer",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "integer", "double",
           "integer", "double", "integer"
)

trainingdata <-read.csv("C:\\Users\\Admin\\Documents\\RProject\\249Project\\data\\train.csv",colClasses=classes, nrows = 1000000, comment.char='', na.strings='NULL')

clickData<-trainingdata[which(trainingdata$click_bool==1),]
bookingData<-trainingdata[which(trainingdata$booking_bool==1),]

library(ggplot2)
# visualization of data imbalance

non_click_ratio = 0.9552639
non_booking_ratio = 0.9721107
click_ratio = 0.04473614
booking_ratio = 0.0278893

ratio <- c(0.9552639, 0.9721107, 0.04473614, 0.0278893)
type <- c("click","booking","click","booking")
bool<- c(FALSE, FALSE, TRUE, TRUE)

prop_ratio <- data.frame(type, ratio, bool)

qplot(factor(type), ratio, data=prop_ratio, stat="identity", geom="bar", fill=factor(bool))



## click/booking/all vs position
hit_df <- rbind(data.frame(category = "clicking", position = clickData$position),
                data.frame(category = "booking", position = bookingData$position),
                data.frame(category = "all", position = trainingdata[1:200000,]$position)
)


hit_df$category <- as.factor(hit_df$category)

ggplot(hit_df, aes(x=position, fill=category)) +
  geom_histogram(binwidth=0.8, colour="grey", position="dodge", alpha = 0.6) +
  scale_fill_manual(breaks=1:4, values=c("blue","red","green")) 


## Combing two plots vs prop_review_score
hit_df_review_score <- rbind(data.frame(category = "clicking", prop_review_score = clickData$prop_review_score),
                             data.frame(category = "booking", prop_review_score = bookingData$prop_review_score),
                             data.frame(category = "all", prop_review_score = trainingdata[1:20000,]$prop_review_score)
)


hit_df_review_score$category <- as.factor(hit_df_review_score$category)

ggplot(hit_df_review_score, aes(x=prop_review_score, fill=category)) +
  geom_histogram(binwidth=0.8, colour="grey", prop_review_score="dodge", alpha = 0.6) +
  scale_fill_manual(breaks=1:3, values=c("blue","red","green")) 
