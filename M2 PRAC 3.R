library(readr)

df <- read_csv("student_exam_scores.csv")

df$Grade <- cut(
  df$exam_score,
  breaks = c(0, 40, 60, 75, 90, 100),
  labels = c("Fail", "Pass", "Average", "Good", "Excellent")
)

df$Attendance_Level <- ifelse(df$attendance_percent >= 75,
                              "High Attendance",
                              "Low Attendance")

table(df$Grade, df$Attendance_Level)

