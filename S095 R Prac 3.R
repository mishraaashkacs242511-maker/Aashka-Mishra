# Install packages (run once)
install.packages("readr")
install.packages("psych")

# Load libraries
library(readr)
library(psych)

# --------------------------------------------
# Load the dataset from the correct file path
# --------------------------------------------
student_exam_scores <- read.csv("/mnt/data/student_exam_scores.csv")

# --------------------------------------------
# Check if it loaded correctly
# --------------------------------------------
head(student_exam_scores)
tail(student_exam_scores)

cat("Dimensions:", dim(student_exam_scores), "\n")
str(student_exam_scores)
summary(student_exam_scores)

cat("Column Names:", names(student_exam_scores), "\n")

# Descriptive statistics
describe(student_exam_scores)

