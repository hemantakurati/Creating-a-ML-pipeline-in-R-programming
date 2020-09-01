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
  )
head(data)
summary(data)
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
    "Diagnosis")
head(data)
data$outcome[data$Diagnosis == 4] = "Malignant"
data$outcome[data$Diagnosis == 2] = "Benign"
data$outcome = as.integer(data$outcome)
head(data)
data$ID <- NULL
head(data)
data$BN <- NULL