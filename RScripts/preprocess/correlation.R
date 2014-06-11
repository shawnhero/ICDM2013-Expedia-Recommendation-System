#plot library
library(lattice) 

matrix <- data.matrix(dataM)
#When we tried to find the correlations from all the features, the correlation distribution indicated that
#most of the features do not have mutual correlation
correlation <- cor(matrix)
summary(correlation)

#TO DO: split features and calculate cor group by group
#Reference: 2_data_description.pdf
#What happened if we categorize them into different group?

#group 1: search criteria
#submatrix for search criteria
srchcrt_matrix <- matrix[, c(	"srch_destination_id", "srch_length_of_stay", 
								"srch_booking_window", "srch_adults_count", 
								"srch_children_count", "srch_room_count",  
								"srch_saturday_night_bool")]
z <- cor(srchcrt_matrix)
levelplot(z)

#group 2: property criteria, both static and dynamic
prop_matrix <- matrix[, c(	"prop_starrating", "prop_review_score", "prop_brand_bool",
							"prop_location_score1", "prop_location_score2", "prop_log_historical_price",
							"position", "price_usd", "promotion_flag")]
z2 <- cor(prop_matrix)
levelplot(z2)

#group 3: visitor information
vistor_matrix <- matrix[, c("visitor_location_country_id", "visitor_hist_starrating", 
							"visitor_hist_adr_usd", "orig_destination_distance")]
z3 <- cor(vistor_matrix)
levelplot(z3)
