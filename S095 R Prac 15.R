# ================================================================
# R Script: Generating Basic Summaries using str() and summary()
# Dataset: student_exam_scores.csv
# ================================================================

# 1. SETUP: Load Dataset
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

print("--- Data Loaded ---")
print(head(df))   # Preview first rows

# ================================================================
# 2. USING str()  → Structure of Dataset
# ================================================================
print("--- OUTPUT OF str() ---")
str(df)

# ================================================================
# 3. USING summary() → Summary Statistics
# ================================================================
print("--- OUTPUT OF summary() ---")
summary(df)

# ================================================================
# 4. IMPROVING summary() BY CONVERTING ID TO FACTOR (Optional)
#    Reason: student_id is categorical, not numeric
# ================================================================
df$student_id <- as.factor(df$student_id)

print("--- OUTPUT OF summary() After Converting student_id to Factor ---")
summary(df)

# ================================================================
# 5. Accessing Specific Summaries
# ================================================================
avg_exam_score <- mean(df$exam_score)
max_study_hours <- max(df$hours_studied)

print(paste("Average Exam Score:", avg_exam_score))
print(paste("Maximum Hours Studied:", max_study_hours))
