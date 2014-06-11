# classes<-c("integer","Date","integer",
# 	"integer", "double", "double", 
# 	"integer", "integer", "integer",
# 	"double", "integer", "double",
# 	"double", "double", "integer",
# 	"double", "integer", "integer",
# 	"integer", "integer", "integer",
# 	"integer", "integer", "logical", #srch_saturday_night_bool
# 	"double", "double", "logical",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"integer", "integer", "double",
# 	"logical", "double", "logical"
# )

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

a <- read.csv('train.csv', colClasses=classes, comment.char="", na.strings='NULL')
n <- dim(a)[1]
p <- dim(a)[2]