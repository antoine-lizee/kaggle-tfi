

# Features ideas
preprocess <- function(X){
  X$Open.Date <- as.Date(X$Open.Date, format = "%m/%d/%Y")
  # Time since restaurant open
  age <- Sys.Date() - X$Open.Date
  ofuscated <- paste0("P", seq(1,37))
  city.group <- factor(X$City.Group)
  return(data.frame(age, city.group, X[, colnames(X) %in% ofuscated]))
}

