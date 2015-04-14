
preprocess <- function(features){
  features$Open.Date <- as.Date(features$Open.Date, format = "%m/%d/%Y")
  
}
