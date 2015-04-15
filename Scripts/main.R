
source("Scripts/init.R")
# loads the data and creates the Xtrain, Xtest and Ytrain data sets

source("Scripts/preprocessing.R")
# imports the preprocessing functions

source("Scripts/helpers.R")
# imports helpers functions

source("Scripts/models.R")
# imports models

CV(Xtrain, Ytrain, getModel(modelSVM, cost = 6))

CV(Xtrain, Ytrain, getModel(modelRF, ntree = 500, mtry = 2))

CV(Xtrain, Ytrain, getModel(modelGBM, distribution = "gaussian", n.trees = 1000))

CV(Xtrain, Ytrain, getHybridModel(modelRF, modelSVM, cost = 6, ntree = 500, mtry = 2))

writeSubmission(Xtest, getHybridModel(modelRF, modelSVM, cost = 6, ntree = 500, mtry = 2)(preproc(Xtrain), Ytrain[,1], preproc(Xtest)), "Hybrid-RF-SVM")