# ==============================================================================
# R Script: Identifying and Handling Duplicates using distinct()
# Dataset: student_exam_scores.csv
# ==============================================================================

library(dplyr)

# ==============================================================================
# 1. IMPORT YOUR DATA
# ==============================================================================
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

print("--- 1. Original Dataset (Full Data) ---")
print(head(df))
print(paste("Total rows:", nrow(df)))

# ==============================================================================
# 2. IDENTIFYING DUPLICATES (Exact duplicates of ENTIRE ROW)
# ==============================================================================
duplicates_report <- df %>%
  group_by(across(everything())) %>%   # group by all columns
  count() %>%                          # count occurrences
  filter(n > 1)                        # keep only duplicates

print("--- 2. Duplicate Rows Found (Exact Matches) ---")
print(duplicates_report)

# ==============================================================================
# 3. REMOVING EXACT DUPLICATES
# ==============================================================================
df_no_dupes <- df %>%
  distinct()   # removes only rows fully identical

print("--- 3. Dataset After Removing Exact Duplicates ---")
print(head(df_no_dupes))
print(paste("Rows after removing duplicates:", nrow(df_no_dupes)))

# ==============================================================================
# 4. REMOVING DUPLICATES BASED ON SPECIFIC COLUMNS
# ==============================================================================
# Example: Keep FIRST occurrence of each student_id
# If student_id repeats, only the FIRST record is kept.

unique_students <- df %>%
  distinct(student_id, .keep_all = TRUE)

print("--- 4. Unique Students (Based on student_id) ---")
print(head(unique_students))
print(paste("Total unique students:", nrow(unique_students)))

# Another Example: Unique combination of (student_id, exam_score)
unique_score_entries <- df %>%
  distinct(student_id, exam_score, .keep_all = TRUE)

print("--- 5. Unique (student_id + exam_score) combinations ---")
print(head(unique_score_entries))
