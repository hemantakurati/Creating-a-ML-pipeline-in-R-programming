set.seed(123)
split = sample.split(data, SplitRatio = 0.8)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)
head(training_set)
head(test_set)

ggplot(data, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of total dataset") +
  theme(legend.position = "none")
ggplot(training_set, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of training dataset") +
  theme(legend.position = "none")
ggplot(test_set, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of testing dataset") +
  theme(legend.position = "none")

corr_mat <- cor(data[,3:ncol(data)])
corrplot(corr_mat, order = "hclust", tl.cex = 1, addrect = 8)

pca_res <- prcomp(data[,3:ncol(data)], center = TRUE, scale = TRUE)
plot(pca_res, type="l")
summary(pca_res)

pca_df <- as.data.frame(pca_res$x)
ggplot(pca_df, aes(x=PC1, y=PC2, col=data$diagnosis)) + geom_point(alpha=0.5)

fitControl <- trainControl(method="cv",
                           number = 5,
                           preProcOptions = list(thresh = 0.99),
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary)

training_set$outcome = NULL
test_set$outcome = NULL

training_set$Diagnosis[training_set$Diagnosis == 4] = 1
training_set$Diagnosis[training_set$Diagnosis ==2] = 0


model_tree = tree(Diagnosis ~ USize +
                    UShape +
                    MA +
                    SECS +
                    BC  +
                    NN  +
                    M,
                  data = training_set)

summary(model_tree)
plot(model_tree, type = "uniform")
text(model_tree, pretty = 0, cex=0.8)

model_tree_pred_train = predict(model_tree, training_set)

model_tree_pred_test = predict(model_tree, test_set)

cv.tree(model_tree)
plot(cv.tree(model_tree))


model_tree_prune = prune.tree(model_tree, best = 5)
summary(model_tree_prune)

plot(model_tree_prune, type = "uniform")


text(model_tree, pretty = 0, cex=0.8)
all_pca <- prcomp(data[,1:8], cor=TRUE, scale = TRUE)

summary(all_pca)