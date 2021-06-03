# getting-and-cleaning-data-project

1. This repository has been created towards fulfillment of the Getting and Cleaning Data course on Coursera. The analysis on the raw data is performed in the file processingScript.R, while the final cleaned dataset has been uploaded as tidyData.txt.
2. We first download the zip file from the internet using a URL.
3. We then unzip the file and place its contents into a data sub-directory.
4. Analyze the directory structure and locate files for both the training and the test sets. Merge both sets into cumulative sets for measurements (xDataset), activities (yDataset) and subjects (subDataset).
5. Load the features and activity labels.
6. Extract columns containing information on the mean and standard deviation of measurements. These shall be columns with a "-mean" or "-std" suffix. To make variable names descriptive, change both aforementioned substrings to "Mean" and "Std" respectively, to ensure case consistency throughout. Eliminate all hyphens and parantheses in column names.
7. The data thus created is extracted through selected columns.
8. The activities are named using descriptive activity names.
9. Find the mean of each variable for each subject and activity. Store the result in a tidy dataset, which is written to the file tidyData.txt.
