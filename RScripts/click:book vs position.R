install.packages("ggplot2")
library(ggplot2)

#get all data clicked and booked
clickData<-a[which(a$click_bool==1),]
bookingData<-a[which(a$booking_bool==1),]

#run qplot of click data
#print(qplot(position, data=clickData, geom="histogram", binwidth=1, main = "# of Clicks vs Position "))
print(qplot(position, data=bookingData, geom="histogram", binwidth=1, main = "# of Bookings vs Position "))



