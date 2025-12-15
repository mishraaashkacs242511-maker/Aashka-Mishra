library(readr)
library(dplyr)

df <- read_csv("student_exam_scores.csv")

df$Grade <- cut(
  df$exam_score,
  breaks = c(0, 40, 60, 75, 90, 100),
  labels = c("Fail", "Pass", "Average", "Good", "Excellent")
)

table(df$Grade)
count(df, Grade)

