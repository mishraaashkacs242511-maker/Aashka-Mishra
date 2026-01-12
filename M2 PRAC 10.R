library(ggplot2)
data <- read.csv("Student Stress Factors.csv")
ggplot(data, aes(x = factor(How.would.you.rate.your.stress.levels.))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Distribution of Student Stress Levels",
    x = "Stress Level",
    y = "Number of Students"
  ) +
  theme_minimal()

