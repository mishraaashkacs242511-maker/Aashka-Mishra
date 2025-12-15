library(readr)

df <- read_csv("student_exam_scores.csv")
t.test(df$exam_score, mu = 50)
t.test(df$exam_score, mu = 50, alternative = "greater")
t.test(df$exam_score, mu = 50, alternative = "less")
