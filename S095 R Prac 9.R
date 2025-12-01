# ==============================================================================
# R Script: Text Manipulation with stringr
# Dataset: Retail Product.csv
# Functions: str_sub(), str_split()
# ==============================================================================

# Install (only once) and load libraries
# install.packages("stringr")
# install.packages("tidyr")
library(stringr)
library(tidyr)
library(dplyr)

# ==============================================================================
# 1. IMPORT YOUR RETAIL DATASET
# ==============================================================================

retail_df <- read.csv("D:/S095 Aashka/Retail Product.csv",
                      na.strings = c("", "NA"))

print("--- Original Dataset (First 5 Rows) ---")
print(head(retail_df, 5))

# Add a new SKU column for text manipulation
# Format: "CAT-PRICE-YEAR"
set.seed(10)

years <- sample(2021:2024, nrow(retail_df), replace = TRUE)

retail_df$SKU <- paste0(retail_df$Category, "-", retail_df$Price, "-", years)

print("--- Dataset with Added SKU Column ---")
print(head(retail_df, 5))

# ==============================================================================
# 2. TEXT SUBSTRING USING str_sub()
# ==============================================================================

# A: Extract first 1 character of Category Code from SKU
retail_df$Cat_Code <- str_sub(retail_df$SKU, 1, 1)

# B: Extract Last 4 characters → Year
retail_df$Year <- str_sub(retail_df$SKU, -4, -1)

print("--- Extracted Substrings (Cat_Code and Year) ---")
print(head(retail_df %>% select(SKU, Cat_Code, Year), 5))

# ==============================================================================
# 3. STRING SPLITTING USING str_split()
# ==============================================================================

# For demonstration: Create a Description column if missing
if (!"Description" %in% names(retail_df)) {
  retail_df$Description <- paste(retail_df$Category, " - Item")
}

# A: Basic split → returns a list
split_list <- str_split(retail_df$Description, " - ")

print("--- First Split Result (List) ---")
print(split_list[[1]])

# B: Using simplify = TRUE → gives a matrix
split_matrix <- str_split(retail_df$Description, " - ", simplify = TRUE)

retail_df$Main_Cat <- split_matrix[, 1]
retail_df$Sub_Cat <- split_matrix[, 2]

print("--- Extracted Main & Sub Categories from Description ---")
print(head(retail_df %>% select(Description, Main_Cat, Sub_Cat), 5))

# ==============================================================================
# 4. BONUS — Using separate() (tidyr)
# ==============================================================================

tidy_df <- retail_df %>%
  separate(SKU, into = c("Dept", "ID", "Mfg_Year"), sep = "-")

print("--- Tidy Output using separate() ---")
print(head(tidy_df %>% select(Dept, ID, Mfg_Year), 5))
