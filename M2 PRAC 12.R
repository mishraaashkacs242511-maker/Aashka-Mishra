library(ggplot2)
data <- read.csv("winequality-red.csv", sep = ",", header = TRUE)
ggplot(data, aes(x = factor(quality))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(
    title = "Frequency of Wine Quality Scores",
    x = "Wine Quality",
    y = "Number of Wines"
  ) +
  theme_minimal()




