library(ggplot2)
data <- read.csv("student_exam_scores.csv")
ggplot(data, aes(x = exam_score)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(
    title = "Distribution of Exam Scores",
    x = "Exam Score",
    y = "Number of Students"
  ) +
  theme_minimal()


ggplot(data, aes(y = exam_score)) +
  geom_boxplot(fill = "lightpink") +
  labs(
    title = "Box Plot of Exam Scores",
    y = "Exam Score"
  ) +
  theme_minimal()



