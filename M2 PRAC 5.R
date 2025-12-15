library(readr)

df <- read_csv("student_exam_scores.csv")
df$Attendance_Group <- ifelse(df$attendance_percent >= 75,
                              "High_Attendance",
                              "Low_Attendance")
t.test(exam_score ~ Attendance_Group, data = df)
t.test(exam_score ~ Attendance_Group, data = df, var.equal = TRUE)
