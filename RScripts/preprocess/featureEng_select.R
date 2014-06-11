# first of all, we need eliminate the imbalance of the data
## output data format


################################################################
### ## drop all competitors information
################################################################
for(i in 27:50){
	dataM[,27] <- NULL
}
## drop position 
dataM$position <- NULL


################################################################
### ## add new scores for each hotel
################################################################
# library(plyr)
# ## question, some hotels might have very few clicks yet high click rates.
# dataM <- ddply(dataM, .(prop_id), mutate, prop_score1= mean(click_bool))
# dataM <- ddply(dataM, .(prop_id), mutate, prop_score2= sum(booking_bool)/sum(click_bool))
# dataM$prop_score1[is.nan(dataM$prop_score1)] <- 0
# dataM$prop_score2[is.nan(dataM$prop_score2)] <- 0


################################################################
### Sampling Method to reduce the imbalance in the training set
################################################################
set.seed(1)
csize <- sum(dataM$click_bool==1)
click_trainset <- dataM[c(which(dataM$click_bool==1), 
		sample(which(dataM$click_bool==0),csize) ), ]
click_trainset$booking_bool <- NULL
bsize <- sum(dataM$booking_bool==1)
book_trainset <- dataM[ c(which(dataM$booking_bool==1),
		sample(which(dataM$booking_bool==0), bsize)),]
book_trainset$click_bool <- NULL
## for the train set, drop the search id
click_trainset$srch_id <- NULL
book_trainset$srch_id <- NULL

### further sample the training set
ctrain <- click_trainset[sample(1:nrow(click_trainset), 20000), ]
btrain <- book_trainset[sample(1:nrow(book_trainset), 20000), ]
testset <- dataM[sample(1:n,2000),]
		

################################################################
### ## GLM Model
################################################################
c_formula <- click_bool~.
b_formula <- booking_bool~.
c_model <- glm(c_formula, data=ctrain, family="binomial")
b_model <- glm(b_formula, data=btrain, family="binomial")

test_click <- predict(c_model, newdata=testset, type="response")
test_book <- predict(b_model, newdata=testset, type="response")









