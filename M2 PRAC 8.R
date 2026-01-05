# Load dataset
data <- read.csv("D:/S095 Aashka/Student Stress Factors.csv")

# Rename columns for simplicity (optional but recommended)
colnames(data) <- c(
  "Sleep_Quality",
  "Headache_Frequency",
  "Academic_Performance",
  "Study_Load",
  "Extracurricular_Activities",
  "Stress_Level"
)

# Convert variables to factors
data$Sleep_Quality <- as.factor(data$Sleep_Quality)
data$Stress_Level <- as.factor(data$Stress_Level)

# Two-Way ANOVA
anova_result <- aov(
  Academic_Performance ~ Stress_Level * Sleep_Quality,
  data = data
)

# Display ANOVA table
summary(anova_result)
