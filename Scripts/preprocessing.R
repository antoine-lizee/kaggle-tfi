

# Features ideas
preproc <- function(X){
  library(mice)
  X$Open.Date <- as.Date(X$Open.Date, format = "%m/%d/%Y")
  # Time since restaurant open
  age <- as.numeric(Sys.Date() - X$Open.Date, units = "days")
  isFCType <- factor(X$Type == "FC")
  isILType <- factor(X$Type == "IL")
  ofuscated.names <- paste0("P", seq(1,37))
  ofuscated <- X[, colnames(X) %in% ofuscated.names]
  ofuscated[ofuscated == 0] <- NA
  imp <- mice(ofuscated, seed = 2015, m = 1, maxit = 3, method = "mean")
  ofuscated <- complete(imp)
  log.ofuscated <- lapply(ofuscated, function(x) log(x+1))
  city.group <- factor(X$City.Group)
  return(data.frame(age, 
                    city.group, 
                    isFCType, 
                    isILType, 
                    ofuscated,
                    log.ofuscated))
}

# ideas
# evaluating the model's performance on different categories (resto categories IL, MB, FC)
# flagging revenue outliers (different model to predict whether a data point is an outlier)
# P1 - P37: as numeric, but get rid of 0 values ()
# package mice for imputation of missing values
