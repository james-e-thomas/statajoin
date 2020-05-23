\name{stata_join}
\alias{stata_join}
\title{Join two tables Stata-style}
\usage{
stata_join(x, y, type = "...", by = "...")
}
\description{
Uses full_join() from dplyr package to mimic the standard merge function in Stata. The join/merge "type" - one of 1:1, 1:m, m:1 or m:m - has to be specified. When 1:1, 1:m or m:1 are selected, an error is returned if the "by" argument does not uniquely identify observations in the master/using dataframes (i.e. arguments "x"/"y") (where relevant). A new variable, "merge", is created and added to the returned dataframe. This variable contains information on whether the new observations are the product of a match or not: 1 = master data only, 2 = using data only, 3 = match. A summary table of this new variable is also returned.
}
\examples{
library(nycflights13)
data(flights, airlines)
merge <- stata_join(flights, airlines, type = "m:1", by = "carrier")
}
