
if(!exists("Xtrain")){
  train <- read.csv('Data/train.csv')
  test <- read.csv('Data/test.csv')
  Xtrain <- train[,-which(names(train) %in% c("revenue"))]
  Ytrain <- train["revenue"]
  Xtest <- test
}

