library(readr)

df <- read_csv("student_exam_scores.csv")
t.test(df$previous_scores, df$exam_score, paired = TRUE)
t.test(df$previous_scores, df$exam_score,
       paired = TRUE,
       alternative = "less")
