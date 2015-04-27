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



cbind(colnames(test), 1:ncol(test))
samplingIndex <- sample(1:nrow(test), size = 10000)
lapply(test[samplingIndex, 6:42], hist, 100)

sapply(paste0("P", 1:37), function(index) {
  print(qplot(x = train[,index], y = train[,"revenue"], 
              geom = c("point", "smooth"), method = "lm") +
          theme_bw() +
          labs(title = index))
})

# Good features: 1,2,6,8,9,10,11,13,21,28,29,
# Not great but without 0s: 19, 22, 23, 
# Potentially good features with 0: 17, 30, 31, 

gfs <- paste0("P", c(1,2,6,8,9,10,11,13,21,28,29, 17, 30, 31))


## put (absolute) correlations on the upper panels,
## with size proportional to the correlations.
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
## put histograms on the diagonal
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(train[c(gfs[1:5], "revenue")]
      , lower.panel = panel.smooth
      , diag.panel = panel.hist 
      , upper.panel = panel.cor
      , pch = 20
      )



