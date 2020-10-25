# Calling library for support vector machine
library(e1071)
SVM = svm(formula = Diagnosis ~ .,
          data = training_set,
          type = 'C-classification',
          kernel = 'linear')  #Training data with SVM function 

# Predicting the values from Trained SVM data
pred_svm = predict(SVM, newdata = test_set[-9])
pred_svm
cm_svm = table(test_set[, 9], pred_svm) # Tabulating Confusion Matrix
cm_svm