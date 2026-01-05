wine <- read.csv("D:/S095 Aashka/winequality-red.csv")
head(wine)

wine$alcohol_level <- ifelse(wine$alcohol >= 10, "High", "Low")


observed <- table(wine$quality)
observed

homo_table <- table(wine$quality, wine$alcohol_level)
homo_table