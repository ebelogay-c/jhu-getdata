
### 1. Merges the training and the test sets to create one data set.
message("Reading data; please be patient...")
xtr <- read.table("data/train/X_train.txt") # slow
message("done reading training data.")
xte <- read.table("data/test/X_test.txt") # smaller set (a bit faster)
message("done reading test data.")

# Note: we are not required to distinguish train from test rows;
# just stack them (training before test rows)
x <- rbind(xtr, xte)
# free up memory (these are large data sets)
rm(xtr, xte)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Note: features.txt coded in 2 cols: index, feature_name
# keep feature names as strings for easier processing
fea <- read.table("data/features.txt", stringsAsFactors=FALSE)
## Keep only the second col (first just mirrors the implicit index)
# make sure first col is just the index...
stopifnot( all(fea[, 1] == 1:nrow(fea)) )
# ... and drop it
fea <- fea[, 2]

## Select only 66 features containing "-mean()" or "-std()"
# Choice: do not include features with "-meanFreq()" (no matching std)
# Note: "(" and ")" are regexp metachars; need escaping
isel <- grep("-mean\\(\\)|-std\\(\\)", fea)

# 48 cols = 6 vectors x 3 coords (x,y,z) x 2 stats (mean, std)
length(fea)
length(fea[isel])
fea[isel]

# keep only the selected 66 out of 561 cols
x <- x[, isel]
fea <- fea[isel]
nfea <- length(fea)
message(nfea, " featuires will be summarized.")
#TODO use fea as column names (see below)

## 3. Uses descriptive activity names to name the activities in the data set
# read activity codes (see #1)
ytr <- read.table("data/train/y_train.txt")
yte <- read.table("data/test/y_test.txt")
# just stack them (training before test rows)
y <- rbind(ytr, yte)
rm(ytr, yte)

# activity labels:
# keep only second col, first is the implicit index 1 to 6
act <- read.table("data/activity_labels.txt")[,2]

# translate activity code to activity label
acty <- act[y[[1]]]
# TODO append them to x later (see below)

# Which subject was used for each observation?
# read activity codes (see #1)
subjtr <- read.table("data/train/subject_train.txt")
subjte <- read.table("data/test/subject_test.txt")
# just stack them (training before test rows)
subj <- rbind(subjtr, subjte)
rm(subjtr, subjte)
# TODO prepend this column to x later (see below)


## 4. Appropriately labels the data set with descriptive variable names.
# 4a. Put subject, x (mean/std features), and y (activity labels) into one big set
# Note: it is a ML tradition to keep the "ground truth" label in the last column
ms <- cbind(subj, x, acty)
rm(subj, x, acty)

# 4b. Set column names
names(ms) <- c("Subject", fea, "Activity")


## 5. Create a tidy data set with the average of each variable for each activity and each subject.
## Split, summarize, combine.
## Note: partial results are lists (not tidy!)
## 5a. Split data into 180 cells by Subject (30) and Activity (6)
bysa <- split(ms[2:(nfea+1)], list(ms$Subject, ms$Activity))

## 5b. summarize each cell (of 180): compute col means of 48 features
mbysa <- sapply(bysa, colMeans)
# observe: result is transposed after sapply
mbysa <- t(mbysa)

## 5c. combine results
# extract row.names formatted as subject.activity
rn <- row.names(mbysa)
# split each by "." (treated as fixed string, not regexp)
rn2 <- sapply(rn, strsplit, ".", fixed=TRUE)
# extract subject and activity from the list of 2-vectors
msub <- sapply(rn2, function(x) x[1])
mact <- sapply(rn2, function(x) x[2])
# put it all together
means <- data.frame(Subject=msub, Activity=mact, mbysa)
dim(means)
# pretty up the colnames: remove double dots
colnames(means) <- gsub("..", "", colnames(means), fixed=TRUE)
# finally, save it to file
write.table(means, file="means.txt", row.names=FALSE)
message("Done.")

## 6. How to read the data back into R?
rmeans <- read.table("means.txt", header=TRUE)
dim(rmeans)
