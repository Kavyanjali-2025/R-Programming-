# ==============================================================================
# R Script: Handling Missing Values (Data Cleaning)
# Dataset: Fraud Transaction Data
# ==============================================================================

# Load necessary libraries
install.packages("tidyr")
library(dplyr)
library(tidyr) # Contains replace_na()

# ==============================================================================
# 1. CREATE AND IMPORT DATASET
# ==============================================================================

# Read dataset (treat empty cells and "NA" as missing)
fraud_df <- read.csv("synthetic_fraud_dataset.csv", na.strings = c("", "NA"))

print("--- 1. Original Data (First 6 Rows) ---")
print(head(fraud_df))

# Check how many NAs are in each column
print("--- Count of Missing Values per Column ---")
print(colSums(is.na(fraud_df)))

# ==============================================================================
# 2. METHOD A: REMOVE MISSING VALUES (na.omit)
# ==============================================================================
# This is the "nuclear option". If a row has even ONE missing value, it is deleted.

clean_omit <- na.omit(fraud_df)

print("--- 2. Data after na.omit() ---")
print(paste("Original rows:", nrow(fraud_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))

# ==============================================================================
# 3. METHOD B: REPLACE MISSING VALUES (replace_na)
# ==============================================================================
# This is the "surgical option". We fill missing values with logical defaults.
# Strategy:
# 1. transaction_type → "Unknown"
# 2. merchant_category → "Other"
# 3. country → "Unspecified"
# 4. amount → Replace with mean amount
# 5. device_risk_score & ip_risk_score → Replace with mean risk scores
# 6. hour → Replace with 0 (midnight)
# 7. is_fraud → Replace with 0 (not fraud)

avg_amount <- mean(fraud_df$amount, na.rm = TRUE)
avg_device_risk <- mean(fraud_df$device_risk_score, na.rm = TRUE)
avg_ip_risk <- mean(fraud_df$ip_risk_score, na.rm = TRUE)

clean_replace <- fraud_df %>%
  replace_na(list(
    transaction_type = "Unknown",
    merchant_category = "Other",
    country = "Unspecified",
    amount = avg_amount,
    device_risk_score = avg_device_risk,
    ip_risk_score = avg_ip_risk,
    hour = 0,
    is_fraud = 0
  ))

print("--- 3. Data after replace_na() ---")
print(clean_replace[3, ]) 
print(head(clean_replace))

print("--- Remaining NAs after replacement ---")
print(colSums(is.na(clean_replace)))
