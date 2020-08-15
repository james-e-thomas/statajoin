# statajoin
Join two dataframes Stata-style in R
Joins corresponding observations from \code{x} (the master data frame) and \code{y} (the using data frame), matching on one or more variables (specified using \code{by}). \code{stata_join()} builds on \code{full_join()} from the \code{dplyr} package (which needs to be loaded) to implement joins in a manner that mimics the standard \code{merge} function in Stata.
