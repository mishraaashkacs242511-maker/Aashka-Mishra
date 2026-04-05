
par(mfrow = c(1,1))
par(mar = c(5,4,4,2))

base_path <- "C:/Users/HP/Downloads"

read_emails <- function(folder_path, label_name) {
  
  files <- list.files(folder_path, full.names = TRUE)
  
  texts <- sapply(files, function(file) {
    content <- readLines(file, warn = FALSE, encoding = "latin1")
    content <- iconv(content, from = "latin1", to = "UTF-8", sub = "")
    paste(content, collapse = " ")
  })
  
  data.frame(
    text = texts,
    label = label_name,
    stringsAsFactors = FALSE
  )
}

easy_ham <- read_emails(paste0(base_path, "/20021010_easy_ham/easy_ham"), "ham")
hard_ham <- read_emails(paste0(base_path, "/20021010_hard_ham/hard_ham"), "ham")
spam <- read_emails(paste0(base_path, "/20021010_spam/spam"), "spam")

data <- rbind(easy_ham, hard_ham, spam)
data$label <- as.factor(data$label)


email_counts <- table(data$label)

# 1. Bar Plot
barplot(email_counts,
        col = c("skyblue", "salmon"),
        main = "Spam vs Ham Email Distribution",
        xlab = "Email Type",
        ylab = "Number of Emails")

# 2. Pie Chart
pie(email_counts,
    col = c("lightgreen", "orange"),
    main = "Spam vs Ham Percentage")

# 3. Email Length
data$email_length <- nchar(data$text)

boxplot(email_length ~ label,
        data = data,
        col = c("lightblue", "pink"),
        main = "Email Length Distribution",
        xlab = "Email Type",
        ylab = "Characters")

# 4. Histogram
hist(data$email_length,
     col = "lightgreen",
     main = "Distribution of Email Length",
     xlab = "Characters",
     border = "black")


library(tm)
library(SnowballC)
library(caret)
library(e1071)
library(randomForest)
library(wordcloud)
library(RColorBrewer)


corpus <- Corpus(VectorSource(data$text))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)


dtm <- DocumentTermMatrix(
  corpus,
  control = list(
    weighting = weightTfIdf,
    wordLengths = c(3, Inf)
  )
)

dtm_sparse <- removeSparseTerms(dtm, 0.98)


term_freq <- colSums(as.matrix(dtm_sparse))

# 5. Top Words Bar Plot
top_terms <- sort(term_freq, decreasing = TRUE)[1:10]

barplot(top_terms,
        las = 2,
        col = "lightblue",
        main = "Top 10 Frequent Words",
        ylab = "Frequency")

# 6. Word Cloud
wordcloud(names(term_freq),
          term_freq,
          max.words = 100,
          colors = brewer.pal(8, "Dark2"))


dataset <- as.data.frame(as.matrix(dtm_sparse))
dataset$label <- data$label

colnames(dataset) <- make.names(colnames(dataset))


set.seed(123)

trainIndex <- createDataPartition(dataset$label, p = 0.8, list = FALSE)

train_data <- dataset[trainIndex, ]
test_data  <- dataset[-trainIndex, ]


svm_model <- svm(label ~ ., data = train_data, kernel = "linear")

svm_pred <- predict(svm_model, test_data)

svm_conf <- confusionMatrix(svm_pred, test_data$label)

print("===== SVM Results =====")
print(svm_conf)

svm_accuracy <- as.numeric(svm_conf$overall["Accuracy"])


rf_model <- randomForest(label ~ ., data = train_data)

rf_pred <- predict(rf_model, test_data)

rf_conf <- confusionMatrix(rf_pred, test_data$label)

print("===== Random Forest Results =====")
print(rf_conf)

rf_accuracy <- as.numeric(rf_conf$overall["Accuracy"])

accuracy_values <- c(svm_accuracy, rf_accuracy)
model_names <- c("SVM", "Random Forest")

barplot(accuracy_values,
        names.arg = model_names,
        col = c("skyblue", "lightgreen"),
        ylim = c(0,1),
        main = "Model Comparison",
        xlab = "Models",
        ylab = "Accuracy",
        border = "black")

