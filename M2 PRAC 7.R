library(readr)
library(dplyr)
df <- read_csv("student_exam_scores.csv")

# View structure
str(df)
df <- df %>%
  mutate(study_group = case_when(
    hours_studied < 3 ~ "Low",
    hours_studied >= 3 & hours_studied <= 6 ~ "Medium",
    hours_studied > 6 ~ "High"
  ))

# Convert to factor
df$study_group <- as.factor(df$study_group)

# Check groups
table(df$study_group)
