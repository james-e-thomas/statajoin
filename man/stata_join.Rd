\name{stata_join}
\alias{stata_join}
\title{Join two data frames Stata-style}
\usage{
stata_join(x, y, type, by, keepusing = NULL)
}
\arguments{
  \item{x}{master data frame.}
  \item{y}{using data frame.}
  \item{type}{one of \code{"1:1"}, \code{"m:1"}, \code{"1:m"} or \code{"m:m"}. This argument is required, no default is specified.}
  \item{by}{a character vector of variables to join by. This argument is required, no default is specified.
  Joining by different variables on \code{x} and \code{y} is not currently supported.}
  \item{keepusing}{a character vector of variables from the using data frame to keep in the joined data frame. If \code{NULL}, the default, all variables are kept.}
}
\description{Joins corresponding observations from \code{x} (the master data frame) and \code{y} (the using data frame), matching on one or more variables (specified using \code{by}). \code{stata_join()} builds on \code{full_join()} from the \code{dplyr} package (which needs to be loaded) to implement joins in a manner that mimics the standard \code{merge} function in Stata.

The join \code{type} - one of \code{"1:1"}, \code{"m:1"}, \code{"1:m"} or \code{"m:m"} - must be specified. When one of \code{"1:1"}, \code{"m:1"} or \code{"1:m"} is selected, an error is returned if \code{by} does not uniquely identify observations in the master/using data frames (where relevant). A new variable, \code{merge}, is created and added to the returned data frame. This variable contains information on whether the new observations are the product of a match or not: 1 = master data only, 2 = using data only, 3 = match. A summary table of this new variable is also returned.
}
\examples{
# Example 1 -------------------------------------------------------------------

library(dplyr)
library(nycflights13)

data(flights, airlines)
flights
airlines

merged_df <- stata_join(flights, airlines, type = "m:1", by = "carrier")


# Example 2 -------------------------------------------------------------------

library(dplyr)

USArrests <- mutate(USArrests, USState = rownames(USArrests))

state.x77 <- state.x77 \%>\%
  as.data.frame() \%>\%
  mutate(USState = rownames(state.x77)) \%>\%
  select(USState, everything())

merged_df <- stata_join(state.x77,
                        USArrests,
                        type = "1:1",
                        by = "USState",
                        keepusing = c("Assault", "Rape"))
}
