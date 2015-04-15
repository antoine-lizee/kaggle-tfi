

# Features ideas
preproc <- function(X){
  X$Open.Date <- as.Date(X$Open.Date, format = "%m/%d/%Y")
  # Time since restaurant open
  age <- as.numeric(Sys.Date() - X$Open.Date, units = "days")
  ofuscated <- paste0("P", seq(1,37))
  city.group <- factor(X$City.Group)
  return(data.frame(age, city.group, X[, colnames(X) %in% ofuscated]))
}

