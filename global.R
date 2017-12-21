library(dplyr)
library(rgdal)
library(leaflet)
library(ggplot2)
library(caret)
library(plotly)

# Read training data collected from Annual Health Survey 
# and District Report Cards on Education for Uttar Pradesh
train <- read.csv("data/train.csv")

# Training is validated through repeated cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=5)

# Bayesian Regularized Neural Networks (BRNN) is the model we use
# The training and analysis in model.R highlights the reason for picking this model
set.seed(7)
brnn_shm <- train(Class5DropOutRate~., data=train, method="brnn", trControl=control)

# Find out which variables influence the drop out rate
imp <- varImp(brnn_shm, scale = FALSE)

# Save the variable importance as a png to be plotted in the app
# Only needs to be run once for a particular model
#png(filename="www/dropoutFactors.png")
#plot(imp)
#dev.off()

# Read data for the state of Uttar Pradesh to visualize using Plotly
data <- read.csv("data/UP.csv")
data <- data[order(data$ChildLabour, data$District),]
data$size <- data$StudentTeacherRatio
colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')

