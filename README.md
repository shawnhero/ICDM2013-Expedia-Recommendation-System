cs249_Parker_Proj1
==================


#Expedia Recommendation System

##Team Member

 __Chenxiao Ma__(lovetomcx@gmail.com)
 
 __Zhaoying Yao__(yaozhaoying@ucla.edu)
 
 __Xu Wu__(wuxu@cs.ucla.edu)
 
 __Zibing Huang__(tercelhuang@gmail.com)

##Proposal Review

 Our proposal said we were interested in three questions:
 
  1. The correlations between different features.
  2. Given all the other features as predictors, we build multiple models to predict the response values, namely `click_bool` and `booking_bool`.
  3. Based on the model we choose from step 2, we build a ranking model to rank all the hotels. (e.g. weighted ranking as a naïve solution)

##Data Description

###Categories of Features

<div align="center">
<img src="http://shawnhero.github.io/Graph/feature_class.png" style="height:200px" />
</div>

###Two Responses to Predict: click_bool and booking_bool

###Objective: Give a rank list for every search in the test data set

##Work Flow Chart

<div align="center">
<img src="http://shawnhero.github.io/Graph/Flow_chart.png" style="height:750px" />
</div>

##Feature Selection
 
The original data set includes 54 features. We have to reduce the size of features to avoid overfitting and unreasonbale computing time.

###Deal with the Features having High Correlations 
 _"Well, find correlation matrix is trivial in R, type `cor(matrix)` and you are done..."_
 
Not really.

 By far, the challenges we have met:
 
    1. Many(_Many!_) columns contain N/A values, which are indicated by `NULL` in the data set. (We need assign a value to calculate the correlation matrix)
    2. Given two features with high correlations, which one should we choose?

####`NULL` values

<div align="center">
<img src="http://shawnhero.github.io/Graph/missing.png" style="height:800px" alt="test"/>
</div>

 We developed three methods to deal with `NULL` values, depending on which colmun they belong to.
 
 
     1. Assign a 0 (e.g. review score)
     2. Assign the minimum value of that column (e.g. property location score)
     3. Assign the average value of that column (e.g. user's history star rating)
     
 <div align="center">
 <img src="http://shawnhero.github.io/Graph/navalues.png" style="width:800px" alt="test"/>
 </div>

And finally we got our (beautiful) correlation level map.
<div align="center">
<!-- <img src="http://shawnhero.github.io/Graph/missing.png" style="height:800px" alt="test"/> -->
<img src="http://shawnhero.github.io/Graph/total_cor.jpg" style="width:800px" alt="test"/>
</div>

####Choose the Features
So how to determine which features we are going to use? Our naïve approach is to drop features having high correlations. We categorized all the features into 4 groups. Here is one example group.

<div align="center">
<img src="http://shawnhero.github.io/Graph/vistor_cor.jpg" style="width:800px" alt="test"/>
</div>

###Drop Unnecessary Features

Some features in the data set have minor effect on the booking and clicking decision.
A representative example is `time`.
<div align="center">
<img src="http://shawnhero.github.io/Graph/hist_dataB.png" style="width:500px" alt="test"/>
<img src="http://shawnhero.github.io/Graph/hist_dataNB.png" style="width:500px" alt="test"/>

<img src="http://shawnhero.github.io/Graph/hist_dataC.png" style="width:500px" alt="test"/>
<img src="http://shawnhero.github.io/Graph/hist_dataNC.png" style="width:500px" alt="test"/>
</div>

###Add New Features
Furthurmore, we added two additional features[1] to improve our model precision.

`mean(click_bool)`: the average value for clicking. This measures the popularity of a property.

`sum(booking_bool)/sum(click_bool))`: the booking ratio of a hotel.

##Remedies for Severe Class Imbalance 

<div align="center">
<img src="http://shawnhero.github.io/Graph/ratio_imbalance.png" style="width:450px" alt="test"/>
</div>

###Proposed Methods

<div align="center">
<img src="http://shawnhero.github.io/Graph/imbalance.png" style="width:450px" alt="test"/>
</div>

1. For most models we use, additional weights could be added to each feature.
2. We could extrat an sample from the training data set with roughly equal number of clicked samples and unclicked features(also booked features and unbooked features).

##Training Model

1. Logistical Regression
2. Neural NetWork
3. Supported Vector Machine

##Learn to Rank: Pointwise approach

<div align="center">
<img src="http://shawnhero.github.io/Graph/ranking_model.png" style="width:400px" alt="test"/>
</div>

##Learn to Rank: Listwise approach (LambdaMART)

##Evaluation Methods



`$DCG_k = \sum\limits_{i=k}\dfrac{2^{rel_i}-1}{\log_2{i}-1}$`


Where,  $rel_i =$ 5: for booked hotels,  1: for clicked hotels, 0: for all the rest

###Self-Evaluation

We extract a sample data set from the training data set and run the nDCG score using the following code.

```R
## input data format
# single srch id, propid, click, book
maxDCG <- function (k, nbook, nclick){
	sum <-0
	for(i in 1:k){
		if(i <= nbook){
			rel <- 5
		}
		else if(i<=nclick){
			rel <- 1
		}
		else{
			rel <- 0
		}
		sum <- sum + (2^rel-1)/(log(i+1)/log(2))
	}
	return(sum)
}
snDCG <- function (data){
	sum <- 0
	for(i in 1:nrow(data)){
		rel <- data[i,3] + 4*data[i,4]
		sum <- sum + (2^rel-1)/(log(i+1)/log(2))
	}
	sum <- sum/maxDCG(nrow(data), sum(data[,4]), sum(data[,3]))
	return(sum)
}
nDCG <- function (data){
	start <- 1
	dcgv <- NULL
	for(i in 2:nrow(data)){
		if(data[i,1]!=data[i-1,1] | i==nrow(data)){
			dcgv <- c(dcgv, snDCG(data[start:(i-1),]))
			start <- i
		}
	}
	return(mean(dcgv))
}
```


###Kaggle Evaluation

It turned out that the score given by our self-evaluation and the kaggle's evalution score and very close to each other!

##Current Results 

0.508, Ranked 35/337 in the leaderboard in Kaggle

##Reference

[1]Combination of Diverse Ranking Models for Personalized Expedia Hotel Searches: http://arxiv.org/pdf/1311.7679v1.pdf

[2]Expedia Data Contest: https://www.kaggle.com/c/expedia-personalized-sort
