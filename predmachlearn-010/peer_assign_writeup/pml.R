#
# Title: Prediction of Activity Quality - Programming Assignment
# Author: Sathish Duraisamy
# Date: 2015JAN20
#

library(caret)
library(randomForest)


pml_write_files = function(x){
    n = length(x)
    for(i in 1:n){
        filename = paste0("problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
    }
}



if (!file.exists("pml-training.csv"))
    download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
if (!file.exists("pml-testing.csv"))
    download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")

training <- read.csv("pml-training.csv", header=TRUE, sep=",", nrow=20000, comment.char = "")
testing <- read.csv("pml-testing.csv", header=TRUE, sep=",", comment.char = "")
dim(training)
dim(testing)

# Set the seed for reproducible random sampling
set.seed(121212)

# Remove the first 7 columns and columns with NA values
# that are not useful for prediction
bad <- which(sapply(training, function(x) { any(is.na(x)) } ))
bad <- union(bad, which(sapply(testing, function(x) { any(is.na(x)) } )))
bad <- union(1:7, bad)

training <- training[, -bad]
testing <- testing[, -bad]
dim(training); dim(testing)  # Dimension after removing bad columns

# Make sure our outcome var 'classe' is treated as a factor var
training$classe <- as.factor(training$classe) # Our outcome var

# Make sure our predictor vars are numeric
for (var in seq(1, NCOL(training)-1)) {
    training[,var] <- as.numeric(training[,var])
    testing[,var] <- as.numeric(testing[,var])
}

nc <- NCOL(testing);
if (names(testing)[nc] != 'classe') {
    testing[,nc] <- rep(c("A", "B", "C", "D", "E"), length.out=NROW(testing))
    colnames(testing)[nc] <- "classe"
}
testing$classe <- as.factor(testing$classe)



require(caret)
inTrain2 <- createDataPartition(y=training$classe, p=0.70, list=FALSE)
train2 <- training[inTrain2, ];  test2 <- training[-inTrain2, ]

# We use method 'classification' as classe can have 5 different discrete values
fit_rf <- randomForest(classe ~ ., data=train2, method="class")
plot(fit_rf, log="y")

pred_rf <- predict(fit_rf, newdata = test2, type="class")
summary(pred_rf)

cmat <- confusionMatrix(pred_rf, test2$class); cmat

require(randomForest)
fit <- randomForest(classe ~ ., data=training, na.action=na.fail)
fit
plot(fit)
p <- predict(fit, newdata=testing)
answers <- as.vector(p); answers
print(answers)




