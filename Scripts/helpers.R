
source("Scripts/preprocessing.R")

rmse <- function(Y,Y.hat){
# computes the Root Mean Square Error between Y (true labels) and Y.hat (prediction)
  error <-  sqrt(mean((Y - Y.hat)^2))
  return(error)
}

CV <- function(X, Y, model, error = rmse, K = 3) {
  # performs a K-fold cross validation
  cat("### Cross validation running...\n")
  N <- nrow(X)
  Xpp <- preproc(X)
  indexes <- sample(K, size = N, replace = T)
  
  perf <- list()
  for (iFold in 1:K) {
    cat("## Iteration", iFold, "\n")
    Xtrain_i <- Xpp[indexes != iFold,]
    Ytrain_i <- Y[indexes != iFold,]
    Xtest_i <- Xpp[indexes == iFold,]
    Ytest_i <- Y[indexes == iFold,]
    Ypred_i <- model(Xtrain_i, Ytrain_i, Xtest_i)
    perf_i <- error(Ytest_i, Ypred_i)
    perf[[iFold]] <- perf_i
  }
  print(unlist(perf))
}

writeSubmission <- function(Xtest, prediction, name){
  sub <- data.frame(Id = Xtest[,"Id"], Prediction = prediction)
  timeString <- gsub(Sys.time(), pattern = "\\s|:|PDT", replacement = "")
  write.csv(sub, paste0("Output/", name, "-", timeString, ".csv"), row.names = F)
}