# next steps
# include binary yes/no for restaurant category

source("Scripts/init.R")
# loads the data and creates the Xtrain, Xtest and Ytrain data sets

source("Scripts/preprocessing.R")
# imports the preprocessing functions

source("Scripts/helpers.R")
# imports helpers functions

source("Scripts/models.R")
# imports models

kRecompute <- F

if(!exists("Xtrain.preproc") || kRecompute) {
  Xtrain.preproc <- preproc(Xtrain)
}
if(!exists("Xtest.preproc") || kRecompute) {
  Xtest.preproc <- preproc(Xtest)
}

launchCVs <- function(name, predictor) {
  predictor <<- predictor
  cat(name, ": ",
      multipleCVs(Xtrain.preproc, Ytrain, predictor),
      "\n", sep = "")
}

launchCVs(name = "RF", predictor = getModel(modelRF, ntree = 500, mtry = 2))

launchCVs("GBM - 0.01", getModel(modelGBM, distribution = "tdist", n.trees = 1000, interaction.depth = 1, shrinkage = 0.01))

launchCVs("GBM - 0.1", getModel(modelGBM, distribution = "tdist", n.trees = 1000, interaction.depth = 1, shrinkage = 0.1))

launchCVs("SVM", getModel(modelSVM, cost = 2))
launchCVs("SVM", getModel(modelRPART))

launchCVs("Hybrid", getHybridModel(modelRF, modelSVM, cost = 2, ntree = 1000, mtry = 2))

# writeSubmission(Xtest, getHybridModel(modelRF, modelSVM, cost = 2, ntree = 1000, mtry = 2)(preproc(Xtrain), Ytrain[,1], preproc(Xtest)), "HybridRFSVM-logpreproc")
writeSubmission(Xtest, getModel(modelGBM, distribution = "tdist", n.trees = 1000, interaction.depth = 1, shrinkage = 0.01)(Xtrain.preproc, Ytrain[,1], Xtest.preproc), "HybridGBM-logpreproc")
# writeSubmission(Xtest, getModel(modelSVM, cost = 2)(Xtrain.preproc, Ytrain[,1], Xtest.preproc), "SVM-cost2")




