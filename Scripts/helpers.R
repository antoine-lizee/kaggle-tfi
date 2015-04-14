

writeSubmission <- function(Xtest, prediction, name){
  sub <- data.frame(Xtest[,"Id"],prediction)
  names(sub) <- c("Id", "Prediction")
  write.csv(sub, paste0("Output/", name, ".csv"), row.names = F)
}