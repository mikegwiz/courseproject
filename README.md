# courseproject
Coursera Getting and Cleaning Data Course Project

Project background:
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data located here, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, are  data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Repo contents:
1. README.md 
Github repo description

2. run_analysis.R

  Assuming that the Samsung data is in your working directory, the run_analysis.R R Script:
  
    A. creates a tidy dataset called result.txt that 
      - merges the training and the test sets to create one data set
      - extracts only the measurements on the mean and standard deviation for each measurement
      - uses descriptive activity names to name the activities in the data set
      - appropriately labels the data set with descriptive variable names
      
    B. creates a second, independent tidy data set called avgvar.txt with the average of each variable for each activity and each subject.
 
 While both datasets are written to your workspace disc, the output of the script is the printed avgvar dataset
 
3. codebook_result.Rmd

  R Markdown file that contains the codebook for results.txt.

4. codebook_result_git.md

  Markdown file that contains the codebook for results, but in a Git viewable format

5. codebook_result.docx

  A word document that contains a description of the features in results.txt as well as the codebook output including the individual
  variable information.
