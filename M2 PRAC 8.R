# Load dataset
data <- read.csv("D:/S095 Aashka/student_exam_scores.csv")

# Create attendance groups
data$attendance_group <- cut(
  data$attendance_percent,
  breaks = c(0, 70, 85, 100),
  labels = c("Low", "Medium", "High")
)

# Create study hours groups
data$study_hours_group <- cut(
  data$hours_studied,
  breaks = c(0, 4, 7, 12),
  labels = c("Low", "Medium", "High")
)

# Convert to factors
data$attendance_group <- as.factor(data$attendance_group)
data$study_hours_group <- as.factor(data$study_hours_group)

# Two-Way ANOVA
anova_result <- aov(
  exam_score ~ attendance_group * study_hours_group,
  data = data
)

# Display result
summary(anova_result)

