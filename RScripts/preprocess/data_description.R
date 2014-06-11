## Visualize Missing Values
library(ggplot2)
missing <- data.frame(matrix(NA, nrow=54, ncol=2))
for(i in 1:p){
	# calcaulate the missing number
	missing[i,2] <- sum(is.na(a[,i]))/nrow(a)
}
missing[,1] <- colnames(a)
names(missing) <- c('names','percentage')
ggplot(missing, aes(x=reorder(names, percentage), y=percentage)) +geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Missing Value Percentage")