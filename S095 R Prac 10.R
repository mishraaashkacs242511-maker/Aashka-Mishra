# ==============================================================================
# R Script: Creating New Variables (Transformations & Calculations)
# Dataset: Retail Product.csv
# ==============================================================================

library(dplyr)
library(tidyr)   # for replace_na()

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================

retail_df <- read.csv("D:/S095 Aashka/Retail Product.csv",
                      na.strings = c("", "NA"))

print("--- Original Dataset (first 5 rows) ---")
print(head(retail_df, 5))

# ==============================================================================
# CLEANING BEFORE TRANSFORMATION
# ==============================================================================
# Replace NA values in numeric columns so calculations do not fail

retail_clean <- retail_df %>%
  mutate(
    Price = replace_na(Price, 0),
    Discount = replace_na(Discount, 0),
    Rating = replace_na(Rating, 0)
  )

print("--- Clean Data for Calculations ---")
print(head(retail_clean, 5))

# ==============================================================================
# 2. METHOD A: ARITHMETIC CALCULATIONS
# ==============================================================================
# Compute Discount Amount & Final Price

retail_calc <- retail_clean %>%
  mutate(
    Discount_Amount = Price * (Discount / 100),
    Final_Price = Price - Discount_Amount
  )

print("--- Arithmetic Calculations (Final Price) ---")
print(head(retail_calc %>% select(Price, Discount, Discount_Amount, Final_Price), 5))

# ==============================================================================
# 3. METHOD B: CONDITIONAL LOGIC (ifelse)
# ==============================================================================
# Create labels based on Rating & Price

retail_logic <- retail_clean %>%
  mutate(
    Quality_Label = ifelse(Rating > 4, "Top Rated", "Average"),
    Price_Category = ifelse(Price > 4000, "Premium", "Budget")
  )

print("--- Conditional Logic Labels ---")
print(head(retail_logic %>% select(Rating, Quality_Label, Price, Price_Category), 5))

# ==============================================================================
# 4. METHOD C: TEXT TRANSFORMATION (paste / paste0)
# ==============================================================================
# Create a readable summary column

retail_text <- retail_clean %>%
  mutate(
    Product_Summary = paste(Category, "- This item is", Stock, "and costs Rs.", Price)
  )

print("--- Text Transformations (Product Summary) ---")
print(head(retail_text$Product_Summary, 5))

# ==============================================================================
# 5. ALL METHODS TOGETHER — FINAL NEW VARIABLES
# ==============================================================================

final_df <- retail_clean %>%
  mutate(
    Discount_Amount = Price * (Discount / 100),
    Final_Price = Price - Discount_Amount,
    Is_High_Value = ifelse(Final_Price > 2000, TRUE, FALSE),
    Status_Report = paste0("Rating: ", round(Rating, 1), 
                           " | Discount: ", Discount, "%")
  )

print("--- FINAL DATASET WITH ALL NEW VARIABLES ---")
print(head(final_df, 5))
