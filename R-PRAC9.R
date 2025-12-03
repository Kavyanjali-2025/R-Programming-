#9. Performing text manipulation using  str_sub(), str_split() (R). import dataset.
# ==============================================================================
# R Script: Text Manipulation with stringr
# Functions: str_sub(), str_split()
# ==============================================================================

# Load necessary library
install.packages("stringr")
install.packages("tidyr") # for separating columns after splitting
library(stringr)
library(tidyr)
library(dplyr)

# ==============================================================================
# 1. CREATE DATASET
# ==============================================================================
# For Walmart dataset, we will manipulate the Date column.
# Format: "DD-MM-YYYY" (e.g., "05-02-2010")

walmart <- read.csv("Walmart_Sales.csv")

print("--- Original Dataset ---")
print(head(walmart, 3))

# ==============================================================================
# 2. USING str_sub() (Substring)
# ==============================================================================
# Scenario: Extract parts of the Date string (Day, Month, Year)
# Syntax: str_sub(string, start, end)

# Example A: Extract the first 2 characters → Day
walmart$Day <- str_sub(walmart$Date, 1, 2)

# Example B: Extract characters 4 & 5 → Month
walmart$Month <- str_sub(walmart$Date, 4, 5)

# Example C: Extract the last 4 characters → Year
walmart$Year <- str_sub(walmart$Date, -4, -1)

print("--- Data after str_sub() ---")
print(walmart %>% select(Date, Day, Month, Year) %>% head(5))

# ==============================================================================
# 3. USING str_split() (Split String)
# ==============================================================================
# Scenario: We want to split the Date into three different parts.

# Method A: Basic Split (Result is a list)
split_list <- str_split(walmart$Date, "-", simplify = FALSE)
print("--- Basic Split Output (List format) ---")
print(split_list[[1]])  # Show first date split

# Method B: Split Fixed (Returns a matrix)
split_matrix <- str_split(walmart$Date, "-", simplify = TRUE)

# Assign the split parts to new columns
walmart$S_Day   <- split_matrix[, 1]
walmart$S_Month <- split_matrix[, 2]
walmart$S_Year  <- split_matrix[, 3]

print("--- Data after str_split() (Manual Assignment) ---")
print(walmart %>% select(Date, S_Day, S_Month, S_Year) %>% head(5))

# ==============================================================================
# 4. BONUS: The "Tidy" Way (separate)
# ==============================================================================
# Using separate() to split the Date directly into three columns.

tidy_data <- walmart %>%
  separate(Date, into = c("T_Day", "T_Month", "T_Year"), sep = "-")

print("--- Bonus: The 'separate' function (easier splitting) ---")
print(tidy_data %>% select(T_Day, T_Month, T_Year) %>% head(5))
