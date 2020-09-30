There are 2 separate datasets (Train and Test) that contain movement data, extracted and derived from smart watches when individual subjects perform 1 of 6 activities.

Each of these 2 datasets comprises 3 separate data files, each file sequenced using the same specific time band method
The 3 files are
-	X data set - The actual data from the smartphone, captured across 66 different variables
-	Y data set - The type of activity being performed (a number from 1-6)
-	The subject performing that activity (a number form 1-30)

In addition there are also 2 baseline datasets labeling the watch feature variables collected, as well as the activities performed, we use these for labelling etc later on

We read in the activity data for X, Y and Subject, combining the test and train directories. Then take the X data set and tidy the columns up alot, extracting only columns that contain mean or STD and we give them better column descriptions. We also replace activity numbers with activity descriptions

We then merge the X,Y and Subject datasets into 1 and aggegate aggregate the merged set by subject and activity, computing the mean for each and then ordering by subj and activity



