library(mlbench)
library(caret)

train <- read.csv("shiny1/Test2/data/train.csv")

control <- trainControl(method="repeatedcv", number=10, repeats=5)

# Evaluate three different models on the same training data
# Random Forest, Bayesian Regularized Neural Networks, Bayesian Ridge Regression

set.seed(7)
rf_shm <- train(Class5DropOutRate~., data=train, method="cforest", trControl=control)
set.seed(7)
nn_shm <- train(Class5DropOutRate~., data=train, method="brnn", trControl=control)
set.seed(7)
bridge_shm <- train(Class5DropOutRate~., data=train, method="bridge", trControl=control)

# Analyze results and pick the model which performs the best

results <- resamples(list(RandomForest=rf_shm, BRNN=nn_shm, BRIDGE=bridge_shm))
summary(results)
bwplot(results)
