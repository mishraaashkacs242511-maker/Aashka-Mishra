# ==============================================================================
# R Script: Reshaping Data with pivot_longer() and pivot_wider()
# Dataset: student_exam_scores.csv
# ==============================================================================
library(dplyr)
library(tidyr)

# ==============================================================================
# 1. IMPORT DATA
# ==============================================================================
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")
head(df)

print("--- 1. Original Data ---")
print(head(df))

# ==============================================================================
# 2. PIVOT_LONGER (Wide → Long)
# Purpose: Combine numeric variables into long format
# ==============================================================================
long_df <- df %>%
  pivot_longer(
    cols = c(hours_studied, sleep_hours, attendance_percent,
             previous_scores, exam_score),
    names_to = "Metric",
    values_to = "Value"
  )

print("--- 2. Long Format (pivot_longer) ---")
print(head(long_df, 10))

# ==============================================================================
# 3. PIVOT_WIDER (Long → Wide)
# Purpose: Convert long_df BACK to original format
# ==============================================================================
wide_df <- long_df %>%
  pivot_wider(
    names_from = Metric,
    values_from = Value
  )

print("--- 3. Wide Format (pivot_wider) ---")
print(head(wide_df))

# ==============================================================================
# 4. ADVANCED EXAMPLE:
# Pivot where rows = student_id and columns = attendance_percent levels
# (Useful for reporting or heatmaps)
# ==============================================================================
attendance_pivot <- df %>%
  mutate(attendance_group = cut(attendance_percent,
                                breaks = c(0, 50, 75, 100),
                                labels = c("Low", "Medium", "High"))) %>%
  select(student_id, attendance_group, exam_score) %>%
  pivot_wider(
    names_from = attendance_group,
    values_from = exam_score
  )

print("--- 4. Attendance Group Pivot ---")
print(head(attendance_pivot))




