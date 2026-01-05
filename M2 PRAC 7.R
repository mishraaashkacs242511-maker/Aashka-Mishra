# Load dataset
data <- read.csv("D:/S095 Aashka/student_exam_scores.csv")
View(data)

# Create attendance groups
data$attendance_group <- cut(
  data$attendance_percent,
  breaks = c(0, 70, 85, 100),
  labels = c("Low", "Medium", "High")
)

# Perform One-Way ANOVA
anova_result <- aov(exam_score ~ attendance_group, data = data)

# Display ANOVA table
summary(anova_result)



