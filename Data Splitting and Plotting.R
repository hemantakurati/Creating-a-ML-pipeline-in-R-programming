set.seed(123)             # Setting Seed Value
  split = sample.split(data, SplitRatio = 0.8) # Splitting data in the ratio of 80:20
  training_set = subset(data, split == TRUE)   # Training data assigned for the 80 split
  test_set = subset(data, split == FALSE)      # Testing data assigned for the remaining data
head(training_set)
head(test_set)
ggplot(data, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of total dataset") +
  theme(legend.position = "none")         # Plotting Data sets
ggplot(training_set, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of training dataset") +
  theme(legend.position = "none")
ggplot(test_set, aes(x = outcome)) +
  geom_bar(aes(fill = "blue")) +
  ggtitle("Diagnosis of testing dataset") +
  theme(legend.position = "none")

corr_mat <- cor(data[,3:ncol(data)])
corrplot(corr_mat, order = "hclust", tl.cex = 1, addrect = 8) # Plotting correlation Matrix

pca_res <- prcomp(data[,3:ncol(data)], center = TRUE, scale = TRUE)
plot(pca_res, type="l")
summary(pca_res)

pca_df <- as.data.frame(pca_res$x)
ggplot(pca_df, aes(x=PC1, y=PC2, col=data$diagnosis)) + geom_point(alpha=0.5)

fitControl <- trainControl(method="cv",
                           number = 5,
                           preProcOptions = list(thresh = 0.99),
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary)  # Controlling printing and resampling of train data 
training_set$outcome = NULL
test_set$outcome = NULL

training_set$Diagnosis[training_set$Diagnosis == 4] = 1  # assigned a value 1 for Malignant for train data
training_set$Diagnosis[training_set$Diagnosis ==2] = 0   # assigned a value 0 for Benign for train data

model_tree = tree(Diagnosis ~ USize +
                    UShape +
                    MA +
                    SECS +
                    BC  +
                    NN  +
                    M,
                  data = training_set)   # Tree Created for the diagnosis by the variables

summary(model_tree)
plot(model_tree, type = "uniform")      # created tree is plotted
text(model_tree, pretty = 0, cex=0.8)

model_tree_pred_train = predict(model_tree, training_set) #  making predictions from modults of model-fitting
model_tree_pred_test = predict(model_tree, test_set)

cv.tree(model_tree)
plot(cv.tree(model_tree))

model_tree_prune = prune.tree(model_tree, best = 5) # Pruning the created tree 
summary(model_tree_prune)

plot(model_tree_prune, type = "uniform") #Plotting the Pruned tree


text(model_tree, pretty = 0, cex=0.8)
all_pca <- prcomp(data[,1:8], cor=TRUE, scale = TRUE)  #Principle component analysis for the data

summary(all_pca)  #summarizing the principle component analysis