data <- read.csv("D:/S095 Aashka/student_exam_scores.csv")
head(data)
str(data)
model <- lm(exam_score ~ hours_studied, data = data)
summary(model)
plot(data$hours_studied, data$exam_score,
     main = "Linear Regression: Hours Studied vs Exam Score",
     xlab = "Hours Studied",
     ylab = "Exam Score")

abline(model)
new_data <- data.frame(hours_studied = c(2, 5, 8))
predict(model, new_data)


