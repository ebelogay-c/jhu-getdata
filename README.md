jhu-getdata
===========

Coursera project for Getting and Cleaning Data (in Data Science specialization by JHU) 

## Input
All data from the original zip archive was extracted into project directory `data` with the following exception: 
the `Inertial Signals` were excluded since they were not used in the analysis.  For simplicity, the script `run_analysis.R` "expects" the input data to be in the local directory `data` as it is here.

Warning: the file `data/train/X_train.txt` excedes the GitHub file size.  It is provided here during peer evaluation, but will be removed afterwards.


## Output
The output of Step 5 is in file `means.txt`.  Please see `codebook.md` for its structure.

The tidy space-separated file contains 160 rows and 68 columns, with a one-row header.  All string values (column names and activity values) are explictly quoted (the default behavior of `write.table`), to ensure that they are read properly as strings my most input commands in R. 

To read the data into R, use the command
```
means <- read.table("means.txt", header=TRUE)
```


## Processing
All processing (excluding the initial unpacking of the data archive) is in the script `run_analysis.R`, as required.  Running the script will read all input files from the local `data` directory and produce the output file `means.txt` in the current directory.  

To run the script in R, type `source run_analysis.R` on the R prompt.

Please note that (one-time) reading the large file `data/train/X_train.txt` (65 MB) takes a few seconds.  The script will emit messages to indicate the beginning and end of these slow operations.

After the script is `source`-d, the R environment will contain the data frame `means` (which is saved to the output file in Step 5).  The data frame `ms` contains the tidy data set after Step 4.  In other words, `ms` is the input to the aggregation in Step 5 and `means` is the output.

The script itself is split into 5 sections, matching the assignment.  Each section begins with a comment like 
```
### 1. Merges the training and the test sets to create one data set.
```

The last section in the script provides and example how to read the data back into R and how to verify its shape and content.












