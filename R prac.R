# ------------------------------------------------------
# 1. Load Packages
# ------------------------------------------------------
library(dplyr)
library(readr)

# ------------------------------------------------------
# 2. Load YOUR Dataset (Correct Path)
# ------------------------------------------------------
exam_score <- read_csv("C:/AASHKA MISHRA/DATA SCIENCE/student_exam_scores.csv")

# View first few rows
head(exam_score)

# ------------------------------------------------------
# 3. METHOD 1 — Using subset()
# ------------------------------------------------------

# Example 1: Single Condition
high_score <- subset(exam_score, exam_score > 40)
cat("Students with exam_score > 40:", nrow(high_score), "\n")
summary(high_score$exam_score)

# Example 2: Multiple Conditions (AND)
top_attendance <- subset(exam_score, exam_score > 35 & attendance_percent > 80)
cat("Students with exam_score > 35 AND attendance > 80:", nrow(top_attendance), "\n")
head(top_attendance)

# Example 3: Multiple Conditions (OR)
study_or_sleep <- subset(exam_score, hours_studied > 7 | sleep_hours < 6)
cat("Students with hours_studied > 7 OR sleep_hours < 6:", nrow(study_or_sleep), "\n")
head(study_or_sleep)

# ------------------------------------------------------
# 4. METHOD 2 — Using dplyr::filter()
# ------------------------------------------------------

# Example 1: sleep < 7 hours
low_sleep <- exam_score |> filter(sleep_hours < 7)
cat("Students with sleep_hours < 7:", nrow(low_sleep), "\n")
summary(low_sleep$sleep_hours)

# Example 2: AND condition
high_attendance_low_prev <- exam_score |>
  filter(attendance_percent > 90, previous_scores < 60)
cat("Students with attendance > 90 AND previous_scores < 60:", nrow(high_attendance_low_prev), "\n")
head(high_attendance_low_prev)

# Example 3: %in% condition
selected_previous <- exam_score |>
  filter(previous_scores %in% c(50, 60, 70))
cat("Students with previous_scores 50, 60 or 70:", nrow(selected_previous), "\n")
table(selected_previous$previous_scores)

# ------------------------------------------------------
# END
# ------------------------------------------------------

