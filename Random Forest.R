library(randomForest)

training_set$Diagnosis <- as.character(training_set$Diagnosis)
training_set$Diagnosis <- as.factor(training_set$Diagnosis) #by changing to factor we can use RF as classifier

regressor = randomForest(x = training_set[9],
                         y = training_set$Diagnosis,
                         ntree = 10)

y_pred = predict(regressor, newdata = test_set)
y_pred
cm = table(test_set[, 9], y_pred)
cm