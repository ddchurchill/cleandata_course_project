#
# Read in the test and train data sets
#
readData <- function()
{
    
     # read in the column names for the training set.
 
  
     features <- read.table('features.txt') 
     if( length(features$V2) != 561) {
          print(sprintf('Length of features is %d\n', length(features$V2)))
          stop('Incorrect number of features read')
     }
     
     # remove the () from all column names.  Way too dirty.
     features$V2 <- gsub('()','', features$V2, fixed=TRUE)
    #
    # create a dataframe called df2 containing the test data with the test subjects and test activities
    #
     
    
    # Read in the test data.  Word count indicates there are 2947 rows of data.  So check nrow()
     df2 <- read.table('~/UCI HAR Dataset/test/X_test.txt', col.names=features$V2)
    if(nrow(df2) != 2947) 
         stop('Incorrect number of rows in X_test.txt')
    
    #
    # read in the list of subjects for the test data.
    # 
    subjects <- read.table('test/subject_test.txt', col.names='subject')
    if( nrow(subjects) != 2947) stop('Incorrect number of rows in subject_test.txt')
    #
    # check that values of subjects is good.  Range is 1 to 30
    if( min(subjects) < 1 | max(subjects) > 30) stop('Bad values in subjects')
    #
    # Add the subjects as a column to the dataframe.
    #
    df2 <- cbind(df2, subjects)
    #
    # Read in the activities list for
    #
    activities <- read.table('test/Y_test.txt', col.names='activity')
    if(nrow(activities) != 2947) stop('Incorrect number of rows in Y_test.txt')
    # check that the activities values are in the range 1 to 6
    if( min(activities ) < 1 | max(activities) > 6) stop('Invalid values in activities')

    df2 <- cbind(df2, activities)
    #
    # Now repeat this process with the training data.  Same code, just different file names and lengths
    #
    #
    # create a dataframe called df1 containing the training data...
    #
    
    
    # Read in the test data.  Word count indicates there are 2947 rows of data.  So check nrow()
    df1 <- read.table('~/UCI HAR Dataset/train/X_train.txt', col.names=features$V2)
    if(nrow(df1) != 7352) 
         stop('Incorrect number of rows in X_train.txt')
    
    #
    # read in the list of subjects for the test data.
    # 
    subjects <- read.table('train/subject_train.txt', col.names='subject')
    if( nrow(subjects) != 7352) stop('Incorrect number of rows in subject_train.txt')
    #
    # Add the subjects as a column to the dataframe.
    #
    df1 <- cbind(df1, subjects)
    #
    # Read in the activities list for
    #
    activities <- read.table('train/Y_train.txt', col.names='activity')
    if(nrow(activities) != 7352) stop('Incorrect number of rows in Y_train.txt')
    
    df1 <- cbind(df1, activities)
    #
    # Now merge the two dataframes and return the result
    df = rbind(df1, df2)
    if( nrow(df) != 10299) stop('Incorrect number of rows in df')
  
    return(df)
}
#
# makeSubset -- subset the merged data set, by selecting only the desired fields.
# Input: the merged dataframe, produced from readData().
# Ouput: subset dataframe, containing mean and std fields, plus activity and subject.
#
makeSubset <- function(dataSet)
{
     #
     # Now subset this data, keeping only the features with ".mean" and ".std" in the names.
     # Search the colnames for labels containing .std and .mean in them.
     # Note that the raw field names had dashes in them.  But read.table was kind enough to sanitize for us.
     # As a QC check, I ran a command line grep on the fields, and verified that there are 79 fields that
     # match this criteria, including ones like meanFreq
     #
     desiredFields <- grep('\\.std|\\.mean', colnames(dataSet), value=TRUE)
     if( length(desiredFields) != 79) stop('Missing some fields.')
     #
     # Now add back in the activity and subject fields of course
     #
     desiredFields <- c(desiredFields, c('activity', 'subject'))
     #
     # subset the data, selecting only the desired fields 
     #
     d1 <- subset(dataSet, select=desiredFields)
     #
     # now aggregate the data by activity and subject, producing means for each group
     #
     tidy.data <- aggregate(d1, by=list(d1$activity, d1$subject), FUN='mean')
     #
     # tidy data should have 30 participants by 6 activites = 180 rows.
     if(nrow(tidy.data) != 180) stop ('Error in tidy.data')

     return(tidy.data)
}
#
# runAnalysis - read in the data and merge into a data frame, then subset the data, and write to a file.
#
runAnalysis <- function()
{
     all.data <- readData()  # read in all data
     tidy.data <- makeSubset(all.data) # subset and aggregate the data and write to file.
     #
     # Now write out the file per instructions: a file ending with .txt
     #
     write.table(tidy.data, 'tidy_data.txt', row.names=FALSE)
  
}

