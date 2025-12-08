# ==============================================================================
# R Script: Vertical Concatenation using rbind()
# Dataset: student_exam_scores.csv
# ==============================================================================

library(dplyr)

# ==============================================================================
# 1. IMPORT DATA
# ==============================================================================
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

print("--- Original Dataset Structure ---")
print(head(df))
print(names(df))

# ==============================================================================
# 2. CREATE TWO SUBSETS TO COMBINE USING rbind()
# ==============================================================================
# Example: Split the dataset into two groups based on attendance

df_low_attendance <- df %>% filter(attendance_percent < 75)
df_high_attendance <- df %>% filter(attendance_percent >= 75)

print("--- Rows in Low Attendance Group ---")
print(nrow(df_low_attendance))

print("--- Rows in High Attendance Group ---")
print(nrow(df_high_attendance))

# ==============================================================================
# 3. VERTICAL CONCATENATION USING rbind()
# ==============================================================================
combined_df <- rbind(df_low_attendance, df_high_attendance)

# ==============================================================================
# 4. VALIDATION
# ==============================================================================

print("--- Combined Data Summary ---")
print(paste("Low attendance rows:", nrow(df_low_attendance)))
print(paste("High attendance rows:", nrow(df_high_attendance)))
print(paste("Total Expected:", nrow(df_low_attendance) + nrow(df_high_attendance)))
print(paste("Actual Combined:", nrow(combined_df)))

print("--- Preview of Combined Dataset (Top 10 rows) ---")
print(head(combined_df, 10))
