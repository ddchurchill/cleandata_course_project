README for the runAnalysis.R project

The code here assumes that the user has downloaded the reference data set into a directory called UCI HAR Dataset.
To run this program, execute in R Console the command runAnalysis().  runAnalysis in turn calls a function readData(), which reads in the data files from the dataset, builds a merged data frame of all the data, and returns that data frame.  Then the function makeSubset() takes that dataset, subsets it to include only the required columns of data, and runs the required mean function on the activities and subjects. 

Finally runAnalysis writes out the tidy data to a local file called tidydata.txt . 
