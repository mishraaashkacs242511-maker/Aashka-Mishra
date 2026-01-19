
data <- read.csv("D:/S095 Aashka/winequality-red.csv")


data$good_quality <- ifelse(data$quality >= 6, 1, 0)


log_model <- glm(
  good_quality ~ alcohol + sulphates + volatile.acidity,
  data = data,
  family = binomial
)


alcohol_seq <- seq(
  min(data$alcohol),
  max(data$alcohol),
  length.out = 100
)


new_data <- data.frame(
  alcohol = alcohol_seq,
  sulphates = mean(data$sulphates),
  volatile.acidity = mean(data$volatile.acidity)
)


pred_prob <- predict(log_model, new_data, type = "response")

plot(
  alcohol_seq,
  pred_prob,
  type = "l",
  lwd = 2,
  xlab = "Alcohol Content",
  ylab = "Probability of Good Quality Wine",
  main = "Logistic Regression Curve: Alcohol vs Wine Quality"
)
