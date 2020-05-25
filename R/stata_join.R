stata_join <- function(x, y, type, by, keepusing) {
  # require that first four arguments are not missing
  if (missing(x)) {
    stop('argument "x" is missing, with no default')
  }
  if (missing(y)) {
    stop('argument "y" is missing, with no default')
  }
  if (missing(type)) {
    stop('argument "type" is missing, with no default')
  }
  if (missing(by)) {
    stop('argument "by" is missing, with no default')
  }

  # check that merge type is valid
  check <- c("1:1", "m:1", "1:m", "m:m")
  if (!type %in% check) {
    stop('argument "type" is not valid, with no default')
  }

  # check that datasets satisfy requirements for merge type
  if (type == "1:1" & anyDuplicated(select(x, by)) != 0) {
    stop("variable(s) does not uniquely identify observations in master")
  }
  if (type == "1:1" & anyDuplicated(select(y, by)) != 0) {
    stop("variable(s) does not uniquely identify observations in using")
  }
  if (type == "1:m" & anyDuplicated(select(x, by)) != 0) {
    stop("variable(s) does not uniquely identify observations in master")
  }
  if (type == "m:1" & anyDuplicated(select(y, by)) != 0) {
    stop("variable(s) does not uniquely identify observations in using")
  }

  # setting out which variables from using to merge onto master
  if (!missing(keepusing)) {
    y2 <- select(y, by, keepusing)
  }
  if (missing(keepusing)) {
    keepusing <- NULL
  }
  if (is.null(keepusing)) {
    y2 <- y
  }

  # merge, create equivalent of Stata _merge variable, and return summary table
  x$xmerge <- 1
  y2$ymerge <- 2
  df <- full_join(x, y2, by = by)
  df$merge <- rowSums(df[,c("xmerge", "ymerge")], na.rm=TRUE)
  df$xmerge <- NULL
  df$ymerge <- NULL
  rm(y2)
  print(table(df$merge))
  df
}
