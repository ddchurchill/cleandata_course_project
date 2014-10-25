Code Book

This code book describes the input files used in the project, the fields used, the algoroithms for processing the data, and the output fields and file and format. The functional requirements were decided on after reading a course blog at https://class.coursera.org/getdata-008/forum/thread?thread_id=24

An important note:  the purpose of the exercise is as much about figuring out what the requirements are as part of the exercise, as it is about computing a result.  The actual data computation does not have to make any sense from a business perspective.  Why would anyone want mean values of a set of standard deviations?  I don't know, and don't care; but that's the way of the data scientist. Maybe the results will have value to someone who uses the data, and maybe not.  And if not, it is easy to delete it all.  

Functional Requirements: 
1. merge the data in the file test/X_test.txt with the data in train/X_train.txt
2. label the columns of data using the rows in features.txt 
3. add a column of data identifying each subject participant from the files named "subject_text.txt" and subject_train.txt
4. add the column data identifying the activity performed in each row using the content of files Y_test.txt and Y_train.txt for the respective data files.  
5. subset the data to select only those columns that contain mean or standard deviation in the names of the columns. 
6. compute mean  value for each remaining column of data aggregated by subject and activity
7. write out the final subset of data to a file named tidydata.txt

Quality Assurance requirements:
1.validate that each of the input files contains the number of rows of data as specified below.  Make the program exit with an error message if any of the files has missing or extra rows.
2. validate the range of values in the subject and activity files, and exit with an error message if any of the data is out of range.
3. validate that the final merged tidy data contains the same number of rows as the two input files combined. Exit the program with an error message if the numbers do not match.
4. column names must not contain parentheses or underscores. 

Input Files:
1. features.txt - contains 561 rows, each row contains the label for a column of data in the data files described here.  
2. test/X_test.txt - contains 561 columns of data, identified by the labels in features.txt, and 2947 rows of data that needs to be merged with data in X_train.txt
3. train/X_train.txt - contains 561 columns of data, identified by the labels in features.txt, and 7352 rows of data that needs to be merged with X_test.txt
4. test/subject_test.txt - contains subject identifiers, integer, one per row, 2947 rows, identifing the person associated with the corresponding row in X_test.txt
5. train/subject_train.txt - contains subject identifiers, integer, one per row, 7352 rows, identifing the person associated with the corresponding row in X_train.txt
6. test/Y_test.txt - contains the activities index, integer, one per row, in range 1 to 6, indicating which activity is associated with each row of X_test.txt
7. train/Y_train.txt - contains the activities index, integer, one per row, in range 1 to 6, indicating which activity is associated with each row of X_train.txt

Algorithm description:
1. read in the column names from features.txt, and remove any parentheses
2. read in the data from X_test.txt, creating a data.frame, using read.table()
3. read in the subject ids from subject_test.txt, and add that as a column to the dataframe using cbind().
4. read in the activity ids from test/Y_test.txt, and add as a column to the dataframe using cbind().
5. repeat this process to create a second data frame, using the data X_train.txt, Y_train.txt, subject_train.txt. 
6. merge the 2 dataframes using rbind().
7. subset the dataframe.  Computationally find all the columns that contain "mean" or "std" in the column names. Use the subset command to select those columns. But remember to all keep the activity and subject columns.
8. Run a mean on each column aggregated by activity and subject, using aggregate().
9. Write out the final dataframe to a file called tidydata.txt using write.table().

Running the analysis:

1. Download the dataset in the directory called UCI HAR Dataset.
2. In the R console, load the program runAnalysis.R, and run the function runAnalysis(). 

Output fields:

Here is a list of the output fields in the tidydata. Group.1 and Group.2 are added by the aggregate function.
The field labeled activities is the activity index, in range 1 to 6, and the field labeled subject is the participant id, in the range 1 to 30.  The other fields contain the mean of the corresponding field for each subject and activity.

[1] "Group.1"                       "Group.2"                       "tBodyAcc.mean.X"              
 [4] "tBodyAcc.mean.Y"               "tBodyAcc.mean.Z"               "tBodyAcc.std.X"               
 [7] "tBodyAcc.std.Y"                "tBodyAcc.std.Z"                "tGravityAcc.mean.X"           
[10] "tGravityAcc.mean.Y"            "tGravityAcc.mean.Z"            "tGravityAcc.std.X"            
[13] "tGravityAcc.std.Y"             "tGravityAcc.std.Z"             "tBodyAccJerk.mean.X"          
[16] "tBodyAccJerk.mean.Y"           "tBodyAccJerk.mean.Z"           "tBodyAccJerk.std.X"           
[19] "tBodyAccJerk.std.Y"            "tBodyAccJerk.std.Z"            "tBodyGyro.mean.X"             
[22] "tBodyGyro.mean.Y"              "tBodyGyro.mean.Z"              "tBodyGyro.std.X"              
[25] "tBodyGyro.std.Y"               "tBodyGyro.std.Z"               "tBodyGyroJerk.mean.X"         
[28] "tBodyGyroJerk.mean.Y"          "tBodyGyroJerk.mean.Z"          "tBodyGyroJerk.std.X"          
[31] "tBodyGyroJerk.std.Y"           "tBodyGyroJerk.std.Z"           "tBodyAccMag.mean"             
[34] "tBodyAccMag.std"               "tGravityAccMag.mean"           "tGravityAccMag.std"           
[37] "tBodyAccJerkMag.mean"          "tBodyAccJerkMag.std"           "tBodyGyroMag.mean"            
[40] "tBodyGyroMag.std"              "tBodyGyroJerkMag.mean"         "tBodyGyroJerkMag.std"         
[43] "fBodyAcc.mean.X"               "fBodyAcc.mean.Y"               "fBodyAcc.mean.Z"              
[46] "fBodyAcc.std.X"                "fBodyAcc.std.Y"                "fBodyAcc.std.Z"               
[49] "fBodyAcc.meanFreq.X"           "fBodyAcc.meanFreq.Y"           "fBodyAcc.meanFreq.Z"          
[52] "fBodyAccJerk.mean.X"           "fBodyAccJerk.mean.Y"           "fBodyAccJerk.mean.Z"          
[55] "fBodyAccJerk.std.X"            "fBodyAccJerk.std.Y"            "fBodyAccJerk.std.Z"           
[58] "fBodyAccJerk.meanFreq.X"       "fBodyAccJerk.meanFreq.Y"       "fBodyAccJerk.meanFreq.Z"      
[61] "fBodyGyro.mean.X"              "fBodyGyro.mean.Y"              "fBodyGyro.mean.Z"             
[64] "fBodyGyro.std.X"               "fBodyGyro.std.Y"               "fBodyGyro.std.Z"              
[67] "fBodyGyro.meanFreq.X"          "fBodyGyro.meanFreq.Y"          "fBodyGyro.meanFreq.Z"         
[70] "fBodyAccMag.mean"              "fBodyAccMag.std"               "fBodyAccMag.meanFreq"         
[73] "fBodyBodyAccJerkMag.mean"      "fBodyBodyAccJerkMag.std"       "fBodyBodyAccJerkMag.meanFreq" 
[76] "fBodyBodyGyroMag.mean"         "fBodyBodyGyroMag.std"          "fBodyBodyGyroMag.meanFreq"    
[79] "fBodyBodyGyroJerkMag.mean"     "fBodyBodyGyroJerkMag.std"      "fBodyBodyGyroJerkMag.meanFreq"
[82] "activity"                      "subject"                      



