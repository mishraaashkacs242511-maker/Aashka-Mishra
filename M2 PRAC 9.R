# Load dataset
data <- read.csv("D:/S095 Aashka/Student Mental health.csv")

# Convert variables to factors
data$Choose.your.gender <- as.factor(data$Choose.your.gender)
data$Do.you.have.Depression. <- as.factor(data$Do.you.have.Depression.)

# Create contingency table
table_data <- table(
  data$Choose.your.gender,
  data$Do.you.have.Depression.
)

# Perform Chi-Square test
chi_result <- chisq.test(table_data)

# Display result
chi_result
