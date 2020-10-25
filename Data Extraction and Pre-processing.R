# Installing Packages
# 'Caret' package for to streamline the process for creating predictive models
# 'TidyVerse' package consists packages for plotting and analysis
# 'Corrplot' package is used to produce graph of correlation matrix 
# 'CaTools' package is used for basic window moving functions
# 'Tree' package is used for classification and regression trees
# 'data.table' package is used as an extension of data.frame
install.packages("Rtools")
library(caret) 
library(tidyverse)
library(corrplot)
library(caTools)
library(tree)
library(data.table)
data <-
  fread(
    'https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin//breast-cancer-wisconsin.data'
  )                # Importing Data from the url.
head(data)         # Prints out the first few rows of the data in the console
summary(data)      # Summarizing the data prints metrics 
colnames(data) <-
  c("ID",
    "CT",
    "USize",
    "UShape",
    "MA",
    "SECS",
    "BN",
    "BC",
    "NN",
    "M",
    "Diagnosis")    # Assigning Variable Names for the data
head(data)
data$outcome[data$Diagnosis == 4] = "Malignant"  # Assigning a Value 'Malignant' to the Diagnosis Variable
data$outcome[data$Diagnosis == 2] = "Benign"     # Assigning a Value 'Benign' to the Diagnosis Variable
data$outcome = as.integer(data$outcome)   # Casting outcome column to integer
head(data)
data$ID <- NULL 
head(data)
data$BN <- NULL