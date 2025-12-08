# ==============================================================================
# R Script: Vertical Concatenation using rbind()
# Datasets Used:
#   1. Iris.csv
#   2. flower_dataset.csv
# ==============================================================================

# 1. SETUP: Import both datasets ------------------------------------------------

iris_df <- read.csv("D:/S095 Aashka/Iris.csv")
flower_df <- read.csv("D:/S095 Aashka/flower_dataset.csv")

print("--- Original Column Names ---")
print(names(iris_df))
print(names(flower_df))

# ==============================================================================
# 2. DATA PREPARATION (Aligning Columns)
# ==============================================================================

# Your Iris.csv column names:
# "Id", "SepalLengthCm", "SepalWidthCm", "PetalLengthCm", "PetalWidthCm", "Species"

# Your flower_dataset.csv column names:
# "species", "height_cm"

# For matching structure, we create common columns:
#   Species   → character
#   Height    → numeric

# 2.1 Prepare Iris Data
iris_clean <- iris_df[, c("Species", "SepalLengthCm")]
names(iris_clean) <- c("Species", "Height")

# 2.2 Prepare Flower Data
flower_clean <- flower_df[, c("species", "height_cm")]
names(flower_clean) <- c("Species", "Height")

# Convert heights to numeric
iris_clean$Height <- as.numeric(iris_clean$Height)
flower_clean$Height <- as.numeric(flower_clean$Height)

# ==============================================================================
# 3. VERTICAL COMBINATION WITH rbind()
# ==============================================================================

combined_data <- rbind(iris_clean, flower_clean)

print("--- Combined Data Summary ---")
print(paste("Iris rows:", nrow(iris_clean)))
print(paste("Flower rows:", nrow(flower_clean)))
print(paste("Total rows expected:", nrow(iris_clean) + nrow(flower_clean)))
print(paste("Total rows actual:", nrow(combined_data)))

# Preview top & bottom rows
print("--- Preview of Combined Data (Top and Bottom) ---")
print(head(combined_data))
print(tail(combined_data))
