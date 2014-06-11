
Most samples of the data set are not clicked or booked.
> sum(dataM$click_bool==0)/sum(nrow(dataM))
[1] 0.9552639
> sum(dataM$booking_bool==0)/sum(nrow(dataM))
[1] 0.9721107
> sum(dataM$click_bool==1)/sum(nrow(dataM))
[1] 0.04473614
> sum(dataM$booking_bool==1)/sum(nrow(dataM))
[1] 0.0278893

Of all the samples clicked, 62% of them are booked.
> sum(dataM$booking_bool==1)/sum(dataM$click_bool==1)
[1] 0.6234178