
############################################################
# Module I: Class_2
# Assignment 2 - Differential Gene Expression Analysis
# AI and Omics Research Internship 2025
# Author: Mira Madi
# Date: 08-31-2025
############################################################


# Function to classify genes based on log2FoldChange and adjusted p-value.

classify_gene <- function(logFC, padj) {
  
  if (logFC > 1 & padj < 0.05) {
    return("Upregulated")
  }
  else if(logFC < -1 & padj < 0.05) {
    return("Downregulated")
  }
  else{
    return("Not_Significant")
  }
  
}


# Define Input and Output

input_dir <- "raw_data"
output_dir <- "results"

# If output folder does not already exist -> create one

if (!dir.exists(output_dir)){
  dir.create(output_dir)
}

# List of input DEG files

files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")

# Prepare empty list to store results in R 

result_list <- list()

# For-Loop to process each file
# For each file within the loop:
#      - import data
#      - handle NA values
#      - add a new column "Status"
#      - save processed files into Results folder
#      - print summary counts of significant, upregulated, and downregulated genes

for (file_name in files_to_process){
  cat ("\nProcessing:" , file_name , "\n")
  
  input_file_path <- file.path(input_dir, file_name)
  output_file_path <- file.path(output_dir , paste0("Processed_" , file_name)) #saving the processed file 
  
  # import datasets
  data <- read.csv(input_file_path, header = TRUE)
  cat("Data imported. Checking missing values in padj... \n")
  
  # replace missing padj values with 1
  data$padj[is.na(data$padj)] <- 1
  
  # apply classify_gene function to each row
  data$status <- mapply(classify_gene, data$logFC, data$padj)
  
  cat("Gene classification done.\n")
  
  # save processed data in R
  result_list[[file_name]] <- data
  
  # save processed file into Results folder
  write.csv(data, output_file_path, row.names = FALSE)
  cat("Processed file saved to:", output_file_path, "\n")
  
  # print summary
  cat("\nSummary for", file_name, ":\n")
  print(table(data$status))
  
}

# RESULTS

# Processing: DEGs_Data_1.csv 
# Data imported. Checking missing values in padj... 
# Gene classification done.
# Processed file saved to: results/Processed_DEGs_Data_1.csv 

# Summary for DEGs_Data_1.csv :
  
  # Not_Significant 
#      22283 

# Processing: DEGs_Data_2.csv 
# Data imported. Checking missing values in padj... 
# Gene classification done.
# Processed file saved to: results/Processed_DEGs_Data_2.csv 

# Summary for DEGs_Data_2.csv :
  
  #Downregulated Not_Significant     Upregulated 
#      1383           52622             670 


# View data in spreadsheet format
View(read.csv("raw_data/DEGs_Data_2.csv"))
View(read.csv("raw_data/DEGs_Data_2.csv"))
View(read.csv("results/Processed_DEGs_Data_1.csv"))
View(read.csv("results/Processed_DEGs_Data_2.csv"))

save.image("MiraMadi_Class_2_Assignment.RData")

