
modelRF <- function(X.preproc, Y, ...) {
  library(randomForest)
  randomForest(Y~., data.frame(X.preproc, Y), ...)
}

modelSVM <- function(X.preproc, Y, ...) {
  library(e1071)
  svm(Y~., data.frame(X.preproc, Y), ...)
}

modelLM <- function(X.preproc, Y, ...) {
  step(lm(Y~., data.frame(X.preproc, Y),...), trace = 0)
}

modelGLM <- function(X.preproc, Y, ...) {
  step(glm(Y~., data.frame(X.preproc, Y), family = "poisson", ...), trace = 0)
}

modelRPART <- function(X.preproc, Y, ...) {
  library(rpart)
  rpart(Y~., data.frame(X.preproc, Y), ...)
}

modelGBM <- function(X.preproc, Y, ...) {
  library(gbm)
  gbm(Y~., data = data.frame(X.preproc, Y), ...)
}

getModel <- function(model, ...) {
  function(Xtrain, Ytrain, Xtest) {
    mod <- model(Xtrain, Ytrain, ...)
    return(predict(mod, Xtest, ...))
  }
}

getHybridModel <- function(model1, model2, ...) {
  function(Xtrain, Ytrain, Xtest) {
    mod1 <- model1(Xtrain, Ytrain, ...)
    mod2 <- model2(Xtrain, Ytrain, ...)
    return(rowMeans(cbind(predict(mod1, Xtest, ...),predict(mod2, Xtest, ...))))
  }
}