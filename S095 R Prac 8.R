# ==============================================================================
# R Script: Handling Missing Values (Data Cleaning)
# Dataset: Retail Product.csv
# ==============================================================================

# Load required libraries
library(dplyr)
library(tidyr)   # For replace_na()

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================

# Import using your correct file path
retail_df <- read.csv("D:/S095 Aashka/Retail Product.csv",
                      na.strings = c("", "NA"))

print("--- Original Data (First 6 Rows) ---")
print(head(retail_df))

# Count missing values per column
print("--- Count of Missing Values per Column ---")
print(colSums(is.na(retail_df)))

# ==============================================================================
# 2. METHOD A: Remove Missing Rows (na.omit)
# ==============================================================================

clean_omit <- na.omit(retail_df)

print("--- Data After na.omit() ---")
print(paste("Original rows:", nrow(retail_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))

# ==============================================================================
# 3. METHOD B: Replace Missing Values (replace_na)
# ==============================================================================

# Convert Price column to numeric (double)
retail_df$Price <- as.numeric(retail_df$Price)

# Calculate mean price again
avg_price <- mean(retail_df$Price, na.rm = TRUE)

clean_replace <- retail_df %>% 
  replace_na(list(
    Category = "Unknown",
    Discount = 0,
    Stock = "Check Warehouse",
    Price = avg_price
  ))

print("--- Data After replace_na() ---")
print(head(clean_replace))

print("--- Remaining NA Counts After Replacement ---")
print(colSums(is.na(clean_replace)))

