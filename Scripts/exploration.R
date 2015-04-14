# Data exploration script
# 2015-04-13 Thomas Legrand

library(randomForest)

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


# Features ideas
# Time since restaurant open
train$Open.Date <- as.Date(train$Open.Date, format = "%m/%d/%Y")

# time since open

