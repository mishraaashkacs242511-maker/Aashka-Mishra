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

ggplot(data, aes(
  x = factor(How.would.you.rate.your.stress.levels.),
  y = Kindly.Rate.your.Sleep.Quality...
)) +
  geom_boxplot(fill = "lightpink") +
  labs(
    title = "Sleep Quality Across Stress Levels",
    x = "Stress Level",
    y = "Sleep Quality Rating"
  ) +
  theme_minimal()





