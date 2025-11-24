# ------------------------------------------------------
# 1. Load Required Package
# ------------------------------------------------------
library(dplyr)

# ------------------------------------------------------
# 2. Load Your Dataset
# ------------------------------------------------------
exam_score <- read.csv("C:/AASHKA MISHRA/DATA SCIENCE/student_exam_scores.csv")

# View first rows
head(exam_score)

# ------------------------------------------------------
# 3. arrange() Examples
# ------------------------------------------------------

# Example 1: Sort by exam_score (Ascending: lowest → highest)
sorted_exam_asc <- exam_score |>
  arrange(exam_score)

head(sorted_exam_asc, 5)

# Example 2: Sort by exam_score (Descending: highest → lowest)
sorted_exam_desc <- exam_score |>
  arrange(desc(exam_score))

head(sorted_exam_desc, 5)

# Example 3: Sort by multiple columns
# 1. attendance_percent ASCENDING
# 2. exam_score DESCENDING within same attendance values
sorted_multi <- exam_score |>
  arrange(attendance_percent, desc(exam_score))

head(sorted_multi, 10)

# Example 4: Combine filter() + arrange()
# Filter students who studied more than 5 hours, then sort by sleep_hours ascending
study_sort <- exam_score |>
  filter(hours_studied > 5) |>
  arrange(sleep_hours)

head(study_sort, 5)

