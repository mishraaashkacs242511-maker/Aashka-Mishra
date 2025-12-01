# Load dataset
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

print(head(df))


print("--- Original Dataset ---")
print(head(df))

# Split dataset into two parts
df_part1 <- df[, c("student_id", "hours_studied", "sleep_hours")]
df_part2 <- df[, c("student_id", "attendance_percent", "previous_scores", "exam_score")]

# Merge using student_id
merged_df <- merge(df_part1, df_part2, by = "student_id")

print("--- Merged Dataset ---")
print(head(merged_df))

library(dplyr)

# Create new rows (new students) with character IDs
new_students <- data.frame(
  student_id = c("S101", "S102"),  # <-- CHARACTER not numbers
  hours_studied = c(5, 3),
  sleep_hours = c(7, 6),
  attendance_percent = c(85, 90),
  previous_scores = c(78, 82),
  exam_score = c(88, 75)
)

# Append using bind_rows
df_appended <- bind_rows(df, new_students)

print(head(df_appended))
