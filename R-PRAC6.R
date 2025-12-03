# ==========================================
# Pract 6.  Merge and Append
# ==========================================

library(dplyr) # Load the library for bind_rows

# ------------------------------------------
# 1. SETUP: Create Two Simple Datasets
# ------------------------------------------
# Imagine these are two CSV files you downloaded.

# Dataset 1: Students Midterm Results
# Contains: ID, Name, Age, Midterm_Grade
data_midterm <- data.frame(
  ID = c(1, 2, 3),
  Name = c("Kavya", "Tanvi", "Daniyal"),
  Age = c(18, 19, 20),
  Midterm_Grade = c(88, 91, 85)
)

# Dataset 2: Students Final Exam Results
# Contains: ID, Name, Age, Final_Grade
data_final <- data.frame(
  ID = c(1, 2, 3),
  Name = c("Kavya", "Tanvi", "Daniyal"),
  Age = c(18, 19, 20),
  Final_Grade = c(92, 94, 89)
)

# Dataset 3: New Students (For appending example)
data_new_students <- data.frame(
  ID = c(4),
  Name = c("Dejore"),
  Age = c(19),
  Midterm_Grade = c(87)
)

print("--- Midterm Data ---")
print(data_midterm)
print("--- Final Exam Data ---")
print(data_final)

# ------------------------------------------
# 2. MERGE (Joining Columns)
# ------------------------------------------
# Scenario: You want to compare Midterm and Final grades for the same students.
# We match them by "ID", "Name", and "Age".

merged_data <- merge(data_midterm, data_final, by = c("ID", "Name", "Age"))

print("--- Merged Data (Columns Added) ---")
print(merged_data)

# ------------------------------------------
# 3. APPEND (Stacking Rows)
# ------------------------------------------
# Scenario: You want to add the new students to the Midterm list.
# We use bind_rows to stack them.

# Note: bind_rows automatically matches column names.
final_list <- bind_rows(data_midterm, data_new_students)

print("--- Appended Data (Rows Added) ---")
print(final_list)
