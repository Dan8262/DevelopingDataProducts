#url_train <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
#url_test <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
#training <- read.csv(url_train)
#testing <- read.csv(url_test)
trainingSet <<- read.csv(file = "train.csv",
                         header = TRUE, 
                         sep = ",", 
                         quote = "\"", 
                         fill = TRUE, 
                         na.strings = c("", "NA"),
                         stringsAsFactors = FALSE,
                         encoding = "UTF-8")


# Removing all record where Age value is missing.
trainingSet <- trainingSet[!is.na(trainingSet$Age),]

# Building reduced training set used for graphics.
reducedTrainingSet <- trainingSet[, c("Name", "Sex", "Age", "Pclass", "Survived")]
reducedTrainingSet$Pclass <- as.factor(reducedTrainingSet$Pclass)
reducedTrainingSet$Survived <- as.factor(reducedTrainingSet$Survived)
reducedTrainingSet$firstLetterName <- toupper(substring(reducedTrainingSet$Name, 1, 1))