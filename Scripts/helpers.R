
source("Scripts/preprocessing.R")

rmse <- function(Y,Y.hat){
# computes the Root Mean Square Error between Y (true labels) and Y.hat (prediction)
  error <-  sqrt(mean((Y - Y.hat)^2))
  return(error)
}

CV <- function(X, Y, model, error = rmse, K = 3) {
  # performs a K-fold cross validation
  N <- nrow(X)
  indexes <- sample(K, size = N, replace = T)
  
  perf <- list()
  for (iFold in 1:K) {
    Xtrain_i <- X[indexes != iFold,]
    Ytrain_i <- Y[indexes != iFold,]
    Xtest_i <- X[indexes == iFold,]
    Ytest_i <- Y[indexes == iFold,]
    Ypred_i <- model(Xtrain_i, Ytrain_i, Xtest_i)
    perf_i <- error(Ytest_i, Ypred_i)
    perf[[iFold]] <- perf_i
  }
  print(paste0("Cross-validation result: ", mean(unlist(perf))))
}

countZerosPerRow <-function(Xtrain) {
  apply(Xtrain, 1, function(x) sum(x == 0 || x == 0.0))
}



writeSubmission <- function(Xtest, prediction, name){
  sub <- data.frame(Id = Xtest[,"Id"], Prediction = prediction)
  timeString <- gsub(Sys.time(), pattern = "\\s|:|PDT", replacement = "")
  write.csv(sub, paste0("Output/", name, "-", timeString, ".csv"), row.names = F)
}