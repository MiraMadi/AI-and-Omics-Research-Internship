

############################################################
# Module I: Basic Syntax (Class Ic)
# AI and Omics Research Internship 2025
# Author: Mira Madi
# Date: 2025-08-14
############################################################


# Practice Exercises 

# ----------------------------------------------------------------------------------------------------------------

# 1. Check Cholesterol level (using if) 
# Write an If statement to check cholesterol level is greater than 240, 
# if true, it will prints “High Cholesterol”

cholesterol <- 230

if (cholesterol > 240) {
  print("High Cholesterol")
}

# ----------------------------------------------------------------------------------------------------------------

# 2. Blood Pressure Status (using if...else)
# Write an if…else statement to check if blood pressure is normal.
# If it’s less than 120, print: “Blood Pressure is normal”
# If false then print: “Blood Pressure is high”

Systolic_bp <- 90

if (Systolic_bp < 120) {
  print("Blood Pressure is normal")
} else{
  print("Blood Pressure is high")
}

# ----------------------------------------------------------------------------------------------------------------

# 3. Automating Data Type Conversion with for loop

# Use patient_info.csv data and metadata.csv

# Loading datasets

raw_data <- read.csv(
  "https://raw.githubusercontent.com/AI-Biotechnology-Bioinformatics/AI_and_Omics_Research_Internship_2025/main/patient_info.csv")
metadata <- read.csv(
  "https://raw.githubusercontent.com/AI-Biotechnology-Bioinformatics/AI_and_Omics_Research_Internship_2025/main/Metadata.csv")

View(raw_data)
View(metadata)

# Create a copy of the dataset to work on.

clean_data <- raw_data 
str(clean_data)

# Results:

# 'data.frame':	20 obs. of  6 variables:
# $ patient_id: chr  "P001" "P002" "P003" "P004" ...
# $ age       : int  34 28 45 39 50 30 41 36 55 29 ...
# $ gender    : chr  "Male" "Female" "Female" "Male" ...
# $ diagnosis : chr  "Cancer" "Normal" "Cancer" "Normal" ...
# $ bmi       : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
# $ smoker    : chr  "Yes" "No" "Yes" "No" ...

clean_metadata <- metadata
str(clean_metadata)

# Results

# 'data.frame':	10 obs. of  5 variables:
# $ name  : chr  "Ali" "Sana" "Ahmed" "Fatima" ...
# $ height: chr  "Tall" "Short" "Tall" "Medium" ...
# $ gender: chr  "Male" "Female" "Male" "Female" ...
# $ age   : int  25 22 28 24 30 21 27 23 26 20
# $ weight: num  68.5 54.7 76.7 59.5 20.7 62.4 74.5 56.4 56.4 78.5



# For clean_data: Need to convert gender, diagnosis, and smoker to factors)
# For clean_metadata: Need to convert height and gender to factors)

# Store their names in a variable

factor_cols_raw <- c("gender", "diagnosis", "smoker")

factor_cols_meta <- c("height", "gender")


# Use a for loop to convert all the columns in factor_cols to factor type.

# Pass factor_cols to the loop as a vector.

for (col in factor_cols_raw) {
     clean_data[[col]] <- as.factor(clean_data[[col]])  
}

for (col in factor_cols_meta) {
  clean_metadata[[col]] <- as.factor(clean_metadata[[col]])  
}

# ----------------------------------------------------------------------------------------------------------------

# 4. Converting Factors to Numeric Codes

 binary_cols <- c("smoker") 

# use ifelse() condition inside the loop

 for (col in binary_cols) {
   clean_data[[col]] <-  ifelse(clean_data[[col]] == "Yes", 1, 0)
 }


# To convert more than one if needed can:

binary_map <- list(
  smoker = "Yes",
  gender = "Female",
  diagnosis = "Cancer"
)

for (col in names(binary_map)) {
  pos <- binary_map[[col]]
  clean_data[[col]] <- ifelse(clean_data[[col]] == pos, 1, 0)
}

str(clean_data)

# Results

# 'data.frame':	20 obs. of  6 variables:
# $ patient_id: chr  "P001" "P002" "P003" "P004" ...
# $ age       : int  34 28 45 39 50 30 41 36 55 29 ...
# $ gender    : num  0 1 1 0 1 0 1 1 0 1 ...
# $ diagnosis : num  1 0 1 0 1 0 1 0 1 0 ...
# $ bmi       : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
# $ smoker    : num  1 0 1 0 1 0 1 0 1 0 ...

# Also wanted to eliminate patient_id column

clean_data$patient_id <- NULL

# ----------------------------------------------------------------------------------------------------------------

#  Verification:

# Checking the updated dataset after conversion

View(clean_data)

str(clean_data)  

# Results:

# 'data.frame':	20 obs. of  5 variables:
# $ age      : int  34 28 45 39 50 30 41 36 55 29 ...
# $ gender   : num  0 1 1 0 1 0 1 1 0 1 ...
# $ diagnosis: num  1 0 1 0 1 0 1 0 1 0 ...
# $ bmi      : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
# $ smoker   : num  1 0 1 0 1 0 1 0 1 0 ...

# Comparing with the original dataset


str(raw_data)   

# Results:

# 'data.frame':	20 obs. of  6 variables:
# $ patient_id: chr  "P001" "P002" "P003" "P004" ...
# $ age       : int  34 28 45 39 50 30 41 36 55 29 ...
# $ gender    : chr  "Male" "Female" "Female" "Male" ...
# $ diagnosis : chr  "Cancer" "Normal" "Cancer" "Normal" ...
# $ bmi       : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
# $ smoker    : chr  "Yes" "No" "Yes" "No" ...

# Checking the updated dataset after conversion

View(clean_data)

str(clean_metadata)  

# Results:

# 'data.frame':	10 obs. of  5 variables:
# $ name  : chr  "Ali" "Sana" "Ahmed" "Fatima" ...
# $ height: Factor w/ 3 levels "Medium","Short",..: 3 2 3 1 3 1 1 2 1 2
# $ gender: Factor w/ 2 levels "Female","Male": 2 1 2 1 2 1 2 1 2 1
# $ age   : int  25 22 28 24 30 21 27 23 26 20
# $ weight: num  68.5 54.7 76.7 59.5 20.7 62.4 74.5 56.4 56.4 78.5


# Comparing with the original dataset

str(metadata)

# Results:

# 'data.frame':	10 obs. of  5 variables:
# $ name  : chr  "Ali" "Sana" "Ahmed" "Fatima" ...
# $ height: chr  "Tall" "Short" "Tall" "Medium" ...
# $ gender: chr  "Male" "Female" "Male" "Female" ...
# $ age   : int  25 22 28 24 30 21 27 23 26 20
# $ weight: num  68.5 54.7 76.7 59.5 20.7 62.4 74.5 56.4 56.4 78.5

# ----------------------------------------------------------------------------------------------------------------



