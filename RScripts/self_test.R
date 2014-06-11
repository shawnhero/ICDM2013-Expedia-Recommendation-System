search_id <- unique(a$srch_id)
sample_sid <- sample(search_id, 5000)
testset <- dataM[ which(dataM$srch_id %in% sample_sid), ]


## should the test and train be the same format? 
tc <- predict(c_model, newdata=testset, type="response")
tb <- predict(b_model, newdata=testset, type="response")

test_result <- data.frame(cbind(testset$srch_id, testset$prop_id, tc+4*tb, testset$click_bool, testset$booking_bool))
names(test_result) <- c("SearchId","PropertyId", "Score", "click_bool", "booking_bool")
test_result <- arrange(test_result, SearchId, -Score)


runscore <- test_result[,c(1,2,4,5)]
print(nDCG(runscore))

