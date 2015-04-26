# Data exploration script
# 2015-04-13 Thomas Legrand

library(randomForest)
source("Scripts/preprocessing.R")
source("Scripts/helpers.R")

train <- read.csv('Data/train.csv')
test <- read.csv('Data/test.csv')
names(train)
names(test)

# Data Description
##################

# Id : Restaurant id. 
# Between 0 and 136500 in training set
# There are 137 restaurants in the training set and 100,000 in test set

# Open Date : opening date for a restaurant
# City : City that the restaurant is in. Note that there are unicode in the names. 
# City Group: Type of the city. Big cities, or Other. 
# Type: Type of the restaurant. FC: Food Court, IL: Inline, DT: Drive Thru, MB: Mobile

# P1, P2 - P37: There are three categories of these obfuscated data. 
# Demographic data are gathered from third party providers with GIS systems. 
# These include population in any given area, age and gender distribution, development scales. 
# Real estate data mainly relate to the m2 of the location, front facade of the location, car park availability. 
# Commercial data mainly include the existence of points of interest including schools, banks, other QSR operators.

# Revenue: The revenue column indicates a (transformed) revenue of the restaurant in a given year and is the target of predictive analysis. 
# Please note that the values are transformed so they don't mean real dollar values. 

# There are no missing values

summary(train)
summary(test)

Xtrain <- train[,-which(names(train) %in% c("revenue"))]
Ytrain <- train["revenue"]

Xtest <- test

XtrainProcessed <- preproc(Xtrain)
XtestProcessed <- preproc(Xtest)

model <- randomForest(XtrainProcessed, Ytrain[,1])
result <- predict(model, XtestProcessed)

#model1 <- step(lm(revenue ~ ., data.frame(XtrainProcessed, Ytrain)), trace = 0)
#result2 <- predict(model1, XtestProcessed)

writeSubmission(Xtest, result, "mySubmission")