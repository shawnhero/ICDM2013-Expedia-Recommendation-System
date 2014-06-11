### Reading data
tclasses<-c("integer","Date","integer",
	"integer", "double", "double", 
	"integer", "integer", "integer",
	"double", "integer", "double",
	"double", "double", 
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
	"integer", "integer", "double"
)

bb <- read.csv('test.csv', colClasses=tclasses, comment.char="", na.strings='NULL')

#bb$prop_score1[is.nan(dataM$prop_score1)] <- 0
#bb$prop_score2[is.nan(dataM$prop_score2)] <- 0

tc <- predict(c_model, newdata=bb, type="response")
tb <- predict(b_model, newdata=bb, type="response")

# set wd to rstudio
setwd('/ubuntu/rstudio')
test_result <- data.frame(cbind(bb$srch_id, bb$prop_id, tc+4*tb))
names(test_result) <- c("SearchId","PropertyId", "Score")
test_result <- arrange(test_result, SearchId, -Score)

## Remove score and write to file
test_result <- test_result[, -3]
write.csv(test_result, file = "result.csv", row.names=F)