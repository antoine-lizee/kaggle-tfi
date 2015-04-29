

# Features ideas
preproc <- function(X){
  #library(mice)
  #obfuscated.cat.names <- paste0("P", c(5,6,7,8,11,15,22,24,33,37))
  #for (f in obfuscated.cat.names){
  #  X[,f] <- as.factor(X[,f])
  #}
  #obfuscated.cat <- X[, colnames(X) %in% obfuscated.cat.names]
  X$Open.Date <- as.Date(X$Open.Date, format = "%m/%d/%Y")
  # Time since restaurant open
  age <- as.numeric(Sys.Date() - X$Open.Date, units = "days")
  isFCType <- factor(X$Type == "FC")
  isILType <- factor(X$Type == "IL")
  #obfuscated.num.names <- paste0("P", c(1:4,9,10,12:14,16:21,23,25:32,34:36))
  #obfuscated.num <- X[, colnames(X) %in% obfuscated.num.names]
  #obfuscated.num[obfuscated.num == 0] <- NA
  #imp <- mice(obfuscated.num, seed = 2015, m = 1, maxit = 3, method = "mean")
  #obfuscated.num <- complete(imp)
  obfuscated.num <- obfuscated.num <- X[, colnames(X) %in% paste0("P", c(1:37))]
  log.obfuscated.num <- lapply(obfuscated.num, function(x) log(x+1))
  city.group <- factor(X$City.Group)

  return(data.frame(age, 
                    city.group, 
                    isFCType, 
                    isILType,
                    obfuscated.num,
                    #obfuscated.cat,
                    log.obfuscated.num))
}