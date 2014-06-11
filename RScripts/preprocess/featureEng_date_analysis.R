
## Observe the date influence
library(lubridate)
library(ggplot2)
# convert date to the weekday
dataM$wday <- wday(dataM$date_time)
# convert date to the date of a month
dataM$mday <- as.numeric(format(dataM$date_time, format='%d'))

dataC <- dataM$wday[dataM$click_bool==1]
dataNC <- dataM$wday[dataM$click_bool==0]
dataB <- dataM$wday[dataM$booking_bool==1]
dataNB <- dataM$wday[dataM$booking_bool==0]

alldata <- rbind(cbind(dataC, rep("Wday, Clicked", length(dataC) )),
				cbind(dataNC, rep("Wday, Not Clicked", length(dataNC))),
				cbind(dataB, rep("Wday, Booked", length(dataB))),
				cbind(dataNB, rep("Wday, Not Booked", length(dataNB)))
	)
alldata <- data.frame(alldata)
names(alldata) <- c("day_of_Week", "label")

ggplot(alldata, aes(day_of_Week, fill = label)) +
  geom_density(alpha = 0.2) + xlim(55, 70)




# ################################################################
# ### ## study the cor between each feature and the click/ book bool
# ################################################################
feature_cov <- data.frame(cbind(names(dd), rep(0, ncol(dd)), rep(0, ncol(dd))))
feature_cov[,2] <- as.numeric(feature_cov[,2])
feature_cov[,3] <- as.numeric(feature_cov[,3])
names(feature_cov) <- c("name", "cov_Click", "cov_Book")

dd <- click_trainset
for(i in 1:ncol(dd)){
	feature_cov[i, 2] <- cor(dd[,i], dd$click_bool)
}
## sort according to the relavance to the click_bool
feature_cov$cov_Click <- abs(feature_cov$cov_Click)
sort_f_click <- feature_cov[order(-feature_cov$cov_Click),]
print(sort_f_click)


dd <- book_trainset
for(i in 1:ncol(dd)){
	feature_cov[i, 2] <- cor(dd[,i], dd$booking_bool)
}
## sort according to the relavance to the book_bool
feature_cov$booking_bool <- abs(feature_cov$booking_bool)
sort_f_book <- feature_cov[order(-feature_cov$booking_bool),]
print(sort_f_book)


