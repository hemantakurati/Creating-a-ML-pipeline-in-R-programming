# Calling Random forest library
library(randomForest)
training_set$Diagnosis <- as.character(training_set$Diagnosis) 
training_set$Diagnosis <- as.factor(training_set$Diagnosis) #by converting the diagnosis variable to factor we can use RF as classifier

regressor = randomForest(x = training_set[9],
                         y = training_set$Diagnosis,
                         ntree = 10)   # Training data with Random Forest Classifier function

y_pred = predict(regressor, newdata = test_set)  # Predicting the values from Trained random forest data
y_pred
cm = table(test_set[, 9], y_pred) # Plotting Confusion Matrix
cm