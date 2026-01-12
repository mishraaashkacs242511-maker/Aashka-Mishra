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

ggplot(data, aes(
  x = How.would.you.rate.you.academic.performance.......,
  y = How.would.you.rate.your.stress.levels.
)) +
  geom_point(color = "darkgreen", size = 3) +
  labs(
    title = "Academic Performance vs Stress Level",
    x = "Academic Performance Rating",
    y = "Stress Level"
  ) +
  theme_minimal()

ggplot(data, aes(x = How.many.times.a.week.do.you.suffer.headaches....)) +
  geom_histogram(binwidth = 1, fill = "orange", color = "black") +
  labs(
    title = "Weekly Headache Frequency",
    x = "Headaches per Week",
    y = "Number of Students"
  ) +
  theme_minimal()

ggplot(data, aes(
  x = how.would.you.rate.your.study.load.,
  y = How.would.you.rate.your.stress.levels.
)) +
  geom_point(color = "purple", size = 3) +
  labs(
    title = "Study Load vs Stress Level",
    x = "Study Load Rating",
    y = "Stress Level"
  ) +
  theme_minimal()



