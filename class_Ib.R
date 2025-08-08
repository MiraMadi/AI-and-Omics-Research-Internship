

############################################################
# Module I: Getting Started with R (Class Ib)
# AI and Omics Research Internship 2025
# Author: Mira Madi
# Date: 2025-08-08
############################################################

# Check current working directory
getwd()  

# Create Required Project Subfolders

dir.create("raw_data")
dir.create("clean_data")
dir.create("scripts")
dir.create("results")
dir.create("plots")
dir.create("tasks")

# loading the dataset into my R environment

data <- read.csv("raw_data/patient_info.csv")


# View data in spreadsheet format
View(data)

# Check structure of the dataset
str(data)

#Results below

#'data.frame':	20 obs. of  6 variables:
#$ patient_id: chr  "P001" "P002" "P003" "P004" ...
#$ age       : int  34 28 45 39 50 30 41 36 55 29 ...
#$ gender    : chr  "Male" "Female" "Female" "Male" ...
#$ diagnosis : chr  "Cancer" "Normal" "Cancer" "Normal" ...
#$ bmi       : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
#$ smoker    : chr  "Yes" "No" "Yes" "No" ...

# Summary of the dataset
summary(data)

#Results below (I checked for null data to be cleaned or dealt with properly but there was none)

#patient_id             age           gender           diagnosis              bmi       
#Length:20          Min.   :26.00   Length:20          Length:20          Min.   :19.80  
#Class :character   1st Qu.:32.50   Class :character   Class :character   1st Qu.:22.40  
#Mode  :character   Median :38.50   Mode  :character   Mode  :character   Median :24.25  
#Mean   :38.95                                         Mean   :24.32  
#3rd Qu.:45.25                                         3rd Qu.:26.25  
#Max.   :55.00                                         Max.   :28.60  
#smoker         
#Length:20         
#Class :character  
#Mode  :character  


# Identify variables with incorrect or inconsistent data types.

#From the str(data) output:
#patient_id: character → fine
#age: integer → fine
#gender: character → better as a factor
#diagnosis: character → better as a factor
#bmi: numeric → fine
#smoker: character → better as a factor or binary variable


# Convert variables to appropriate data types where needed

# Convert gender and diagnosis to factors
data$gender_fac <- as.factor(data$gender)
data$diagnosis_fac <- as.factor(data$diagnosis)

# Convert factor to numeric using ifelse statement
data$gender_num <- ifelse(data$gender_fac == "Female", 1, 0)
data$diagnosis_num <- ifelse(data$diagnosis_fac == "Cancer", 1, 0)

# Create binary factor variable for smoker (1 = Yes, 0 = No)

data$smoker_binary <- ifelse(data$smoker == "Yes", 1, 0)

# Could also work as factor
#data$smoker_binary <- factor(data$smoker_binary,
                            # levels = c(0, 1),
                           #  labels = c("No", "Yes"))


str(data)

# Results below

#'data.frame':	20 obs. of  11 variables:
#$ patient_id   : chr  "P001" "P002" "P003" "P004" ...
#$ age          : int  34 28 45 39 50 30 41 36 55 29 ...
#$ gender       : chr  "Male" "Female" "Female" "Male" ...
#$ diagnosis    : chr  "Cancer" "Normal" "Cancer" "Normal" ...
#$ bmi          : num  22.5 20.3 26.7 23.8 27.1 21.9 25.4 24.2 28.6 19.8 ...
#$ smoker       : chr  "Yes" "No" "Yes" "No" ...
#$ gender_fac   : Factor w/ 2 levels "Female","Male": 2 1 1 2 1 2 1 1 2 1 ...
#$ diagnosis_fac: Factor w/ 2 levels "Cancer","Normal": 1 2 1 2 1 2 1 2 1 2 ...
#$ smoker_binary: num  1 0 1 0 1 0 1 0 1 0 ...
#$ gender_num   : num  0 1 1 0 1 0 1 1 0 1 ...
#$ diagnosis_num: num  1 0 1 0 1 0 1 0 1 0 ...

# I also wanted to clear columns that were changed
data$gender <- NULL
data$diagnosis <- NULL
data$smoker <- NULL

# Finally I wanted to practice on some visualizations as I have already learned about it

# Visualize distribution of numeric variables

hist(data$age, main="Age Distribution", xlab="Age", col="skyblue")
hist(data$bmi, main="BMI Distribution", xlab="BMI", col="lightgreen")

# Compare numeric variables across groups

boxplot(bmi ~ diagnosis_fac, data=data, main="BMI by Diagnosis", xlab="Diagnosis", ylab="BMI", col=c("orange","lightblue"))
boxplot(age ~ smoker_binary, data=data, main="Age by Smoking Status", xlab="Smoker", ylab="Age", col=c("pink","lightgreen"))

# Show counts of categorical variables

barplot(table(data$gender_fac), main="Gender Counts", col=c("lightblue","pink"))
barplot(table(data$diagnosis_fac), main="Diagnosis Counts", col=c("lightgreen","salmon"))
barplot(table(data$smoker_binary), main="Smoking Status Counts", col=c("gray","darkred"))

# Check relationship between Age and BMI

plot(data$age, data$bmi, main="Age vs BMI", xlab="Age", ylab="BMI", pch=19, col="blue")


# Save the cleaned dataset in your clean_data folder with the name patient_info_clean.csv

write.csv(data, file = "clean_data/patient_info_clean.csv", row.names = FALSE)
