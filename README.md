# statajoin - Join two dataframes Stata-style in R
Joins corresponding observations from x (the master data frame) and y (the using data frame), matching on one or more variables (specified using "by"). stata_join() builds on full_join() from the dplyr package (which needs to be installed) to implement joins in a manner that mimics the standard merge function in Stata.
