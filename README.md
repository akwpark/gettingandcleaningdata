## Getting And Cleaning Data

This was a project done for the **Getting and Cleaning Data** Coursera course.

## Preparation

Before you do anything, open the **run_analysis.R** file in RStudio and run the code.

Now set the working directory to "UCI HAR Dataset" prior to running the code.
	
Alternatively, run **downloadData()** in the console and it should download the necessary files and set the working directory for you.

## Running the Analysis

Run the function **runAnalysis()** in the console. It should return the tidy data set.

## Evaluation of Analysis Files

The comments in the code describe what the analysis file did. 

The steps the code takes are listed below.

1. Gets all the necessary data.
2. Adds column names to the relevant data
3. Binds all the relevant data.
4. Merges the data such that the activity numbers are changed to their respective activity names.
5. Creates descriptive variable names.
6. Gets only the columns with the relevant terms in it.
7. Creates the tidy data and writes it to a file.

## Codebook

The codebook is the **codebook.md** file.