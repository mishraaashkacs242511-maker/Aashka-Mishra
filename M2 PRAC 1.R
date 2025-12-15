# Load required libraries
library(psych)   # for describe()
library(readr)   # for reading CSV

# Read the dataset
df <- read_csv("student_exam_scores.csv")

# View dataset
View(df)

# Descriptive statistics
summary(df)
describe(df)



