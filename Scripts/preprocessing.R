

# Features ideas
preproc <- function(X){
  library(mice)
  X$Open.Date <- as.Date(X$Open.Date, format = "%m/%d/%Y")
  # Time since restaurant open
  age <- as.numeric(Sys.Date() - X$Open.Date, units = "days")
  isFCType <- factor(X$Type == "FC")
  isILType <- factor(X$Type == "IL")
  obfuscated.names <- paste0("P", seq(1,37))
  obfuscated <- X[, colnames(X) %in% obfuscated.names]
  obfuscated[obfuscated == 0] <- NA
  imp <- mice(obfuscated, seed = 2015, m = 1, maxit = 3, method = "mean")
  obfuscated <- complete(imp)
  log.obfuscated <- lapply(obfuscated, function(x) log(x+1))
  city.group <- factor(X$City.Group)
  return(data.frame(age, 
                    city.group, 
                    isFCType, 
                    isILType, 
                    obfuscated,
                    log.obfuscated))
}

# ideas
# evaluating the model's performance on different categories (resto categories IL, MB, FC)
# flagging revenue outliers (different model to predict whether a data point is an outlier)
