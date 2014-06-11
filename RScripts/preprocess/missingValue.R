dataM <- a
## dealing with missing values
# hotel review score. Assumption, users don't like hotels with no score

dataM$prop_review_score[is.na(dataM$prop_review_score)] <- 0
min_score <- range(dataM$prop_location_score2, na.rm=T)
dataM$prop_location_score2[is.na(dataM$prop_location_score2)] <- min_score
min_srch_score <- range(dataM$srch_query_affinity_score, na.rm=T)
dataM$srch_query_affinity_score[is.na(dataM$srch_query_affinity_score)] <- min_srch_score

# competitor information
for(i in seq(28,51, by=1)){
	dataM[is.na(dataM[,i]), i] <- 0
}

# gross booking information (dropped)
dataM$gross_bookings_usd <- NULL
## the date column (dropped), why dropping this? see my four figures!
dataM$date_time <- NULL

# for NAs of users' historical data,
# we replace them by the mean value of the column
avg_v_usd <- mean(dataM$visitor_hist_adr_usd, na.rm=T)
avg_v_star <- mean(dataM$visitor_hist_starrating, na.rm=T)
dataM$visitor_hist_adr_usd[is.na(dataM$visitor_hist_adr_usd)] <- avg_v_usd
dataM$visitor_hist_starrating[is.na(dataM$visitor_hist_starrating)] <- avg_v_star
avg_dis <- mean(dataM$orig_destination_distance, na.rm=T)
dataM$orig_destination_distance[is.na(dataM$orig_destination_distance)] <- avg_dis

## Now we should have the following equal to 0
#print(sum(is.na(dataM)))



