# ============================================================
# Extracting Date Components using lubridate (Student Dataset)
# ============================================================

library(dplyr)
library(lubridate)

# 1. Load your dataset
df <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

# ------------------------------------------------------------
# 2. Add a sample exam date column (Because your dataset has none)
# ------------------------------------------------------------

# Example: Assign random exam dates in 2024
set.seed(123)  # for reproducibility

df <- df %>% 
  mutate(
    exam_date = sample(seq(ymd("2024-01-01"), ymd("2024-12-31"), by = "day"),
                       size = n(), replace = TRUE)
  )

# ------------------------------------------------------------
# 3. Extract date components
# ------------------------------------------------------------

df_processed <- df %>% 
  mutate(
    Year = year(exam_date),
    Month_Number = month(exam_date),
    Month_Name = month(exam_date, label = TRUE),
    Day = day(exam_date),
    Weekday_Number = wday(exam_date),
    Weekday_Name = wday(exam_date, label = TRUE, abbr = FALSE),
    Quarter = quarter(exam_date),
    Day_of_Year = yday(exam_date)
  )

# ------------------------------------------------------------
# 4. Print Results
# ------------------------------------------------------------
print("--- Data with Extracted Date Components ---")
print(df_processed)
