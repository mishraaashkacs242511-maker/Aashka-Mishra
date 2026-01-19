install.packages("writexl", dependencies = TRUE)
install.packages("gridExtra", dependencies = TRUE)

library(writexl)
library(gridExtra)

# Load dataset
student_data <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

# Check column names
print(colnames(student_data))  # Verify column names

# Create linear regression model (correct column names)
linear_model <- lm(exam_score ~ hours_studied, data = student_data)

# New data for prediction
linear_new_data <- data.frame(hours_studied = c(2, 5, 8))

# Predict exam scores
linear_predictions <- predict(linear_model, linear_new_data)

# Combine predictions into a data frame
linear_results <- data.frame(
  hours_studied = linear_new_data$hours_studied,
  predicted_exam_score = linear_predictions
)

# Export predictions
write.csv(linear_results, "D:/S095 Aashka/linear_predictions.csv", row.names = FALSE)
write_xlsx(linear_results, "D:/S095 Aashka/linear_predictions.xlsx")

# Export plot to PDF
pdf("D:/S095 Aashka/linear_regression_plot.pdf", width = 8, height = 6)
plot(student_data$hours_studied, student_data$exam_score,
     main = "Linear Regression: Hours Studied vs Exam Score",
     xlab = "Hours Studied",
     ylab = "Exam Score",
     pch = 19, col = "blue")
abline(linear_model, col = "red", lwd = 2)
dev.off()

# Export model summary
capture.output(summary(linear_model),
               file = "D:/S095 Aashka/linear_model_summary.txt")

# Load dataset
wine_data <- read.csv("D:/S095 Aashka/winequality-red.csv")

# Check column names
print(colnames(wine_data))

# Create binary variable for good quality wine
wine_data$good_quality <- ifelse(wine_data$quality >= 6, 1, 0)

# Logistic regression model
log_model <- glm(
  good_quality ~ alcohol + sulphates + volatile.acidity,
  data = wine_data,
  family = binomial
)

# Create sequence of alcohol values for prediction
alcohol_seq <- seq(min(wine_data$alcohol), max(wine_data$alcohol), length.out = 100)

# New data for prediction
log_new_data <- data.frame(
  alcohol = alcohol_seq,
  sulphates = mean(wine_data$sulphates),
  volatile.acidity = mean(wine_data$volatile.acidity)
)

# Predict probabilities
pred_prob <- predict(log_model, log_new_data, type = "response")

# Combine predictions into a data frame
logistic_results <- data.frame(
  alcohol = alcohol_seq,
  probability_good_quality = pred_prob
)

# Export predictions
write.csv(logistic_results, "D:/S095 Aashka/logistic_predictions.csv", row.names = FALSE)
write_xlsx(logistic_results, "D:/S095 Aashka/logistic_predictions.xlsx")

# Export logistic regression curve to PDF
pdf("D:/S095 Aashka/logistic_regression_plot.pdf", width = 8, height = 6)
plot(alcohol_seq, pred_prob, type = "l", lwd = 2,
     xlab = "Alcohol Content",
     ylab = "Probability of Good Quality Wine",
     main = "Logistic Regression: Alcohol vs Wine Quality",
     col = "darkgreen")
dev.off()

# Export logistic regression summary
capture.output(summary(log_model),
               file = "D:/S095 Aashka/logistic_model_summary.txt")

