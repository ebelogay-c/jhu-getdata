Variables in means.txt
======================

The space-separated file means.txt contains 160 rowsd and 68 columns, with a header.  To read the data into R, use the command
```
rmeans <- read.table("means.txt", header=TRUE)
```


The table contains 2 grouping variables and 66 aggregates.

## Grouping variables: Subject and Activity

As required in Step 5 of the project, the data is grouped by subject and activity.  
These are the first two columns in the data (the independent variables in a tidy data set).
The six activity labels are copied from the original file `activity_labels.txt`.
The subject codes (from 1 to 30) appear exactly as in the original files 
`train/subject_train.txt` and 
`data/test/subject_test.txt`.

All 30 subjects went through all 6 activities, forming 30*6 = 180 factor groups.  
Each row on the table corresponds to one of these 180 factor groups.

## Measurements

Each of the remaining 66 columns (from 3 to 68) represents an aggregated feature. 
Only 66 of the 561 original feature labels contain `-mean()` or `-std()`,
so only those features were aggregated, as required.  
For simplicity, features containing `-meanFreq()` were excluded (besides, they do not have matching stdFreq features).

All feature labels were slightly modified in the following fashion, so that they can be legal R variable names:
```
original: tBodyAcc-mean()-X
modified: tBodyAcc.mean.X
```

For full description of the meaning of each feature, please see the original files `REAAD.me` and `features_info.txt` supplied with the data.

The value of each table cell is the mean of the feature (specified by the column name) for each value of Subject and Activity.  
Since the original features were normalized to be between -1.0 amd 1.0, so are their means.  Therefore, each table cell shoould be a number betyween -1 and 1.







