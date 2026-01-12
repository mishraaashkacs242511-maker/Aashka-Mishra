library(ggplot2)
library(dplyr)

# Load dataset
data <- read.csv("D:/S095 Aashka/Student Stress Factors.csv", header = TRUE, sep = ",")

# Rename columns for simplicity
data <- data %>%
  rename(
    Hours_Study = how.would.you.rate.your.study.load.,
    Stress_Level = How.would.you.rate.your.stress.levels.
  )

# Scatter plot
ggplot(data, aes(x = Hours_Study, y = Stress_Level)) +
  geom_point(color = "steelblue", size = 3) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Scatter Plot: Hours of Study vs Stress Level",
    x = "Hours of Study",
    y = "Stress Level"
  ) +
  theme_minimal()

# Load required libraries
library(ggplot2)
library(dplyr)

# Create frequency table for Stress Level
stress_data <- data %>%
  count(Stress_Level)

# Create Pie Chart
ggplot(stress_data, aes(x = "", y = n, fill = Stress_Level)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Distribution of Student Stress Levels",
    fill = "Stress Level"
  ) +
  theme_void()

# Load libraries
library(ggplot2)
library(dplyr)

# Create High-Low data (min and max study hours per stress level)
high_low_data <- data %>%
  group_by(Stress_Level) %>%
  summarise(
    Low = min(Hours_Study, na.rm = TRUE),
    High = max(Hours_Study, na.rm = TRUE)
  )

# Create High-Low Chart
ggplot(high_low_data, aes(x = Stress_Level)) +
  geom_linerange(aes(ymin = Low, ymax = High), linewidth = 1.2) +
  geom_point(aes(y = Low), size = 3) +
  geom_point(aes(y = High), size = 3) +
  labs(
    title = "High-Low Chart of Study Hours by Stress Level",
    x = "Stress Level",
    y = "Study Hours"
  ) +
  theme_minimal()


