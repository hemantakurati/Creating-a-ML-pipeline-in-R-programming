library(class)
pred_knn = knn(train = training_set[, -9],
               test = test_set[, -9],
               cl = training_set[, 9],
               k = 5)
pred_knn

cm_knn = table(test_set[, 9], pred_knn)
cm_knn