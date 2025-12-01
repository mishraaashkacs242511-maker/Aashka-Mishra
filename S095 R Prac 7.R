library(dplyr)   # select() is part of dplyr

# Import your dataset
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

print("--- Original Dataset (First 3 Rows) ---")
print(head(df, 3))

selected_cols <- df %>%
  select(student_id, hours_studied, exam_score)

print("--- Selected Specific Columns ---")
print(head(selected_cols, 3))

range_cols <- df %>%
  select(hours_studied:previous_scores)

print("--- Selected Range of Columns ---")
print(head(range_cols, 3))

starts_with_s <- df %>%
  select(starts_with("s"))

print("--- Selected Columns Starting with 's' ---")
print(head(starts_with_s, 3))

drop_one <- df %>%
  select(-sleep_hours)

print("--- Dataset with 'sleep_hours' dropped ---")
print(names(drop_one))

drop_multiple <- df %>%
  select(-attendance_percent, -previous_scores)

print("--- Dataset with 2 columns dropped ---")
print(names(drop_multiple))

drop_range <- df %>%
  select(-(sleep_hours:previous_scores))

print("--- Dataset after dropping 'sleep_hours' to 'previous_scores' ---")
print(names(drop_range))

