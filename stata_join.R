stata_join <- function(x, y, type, by){

  # require that arguments are not missing
  if (missing(x)) stop('argument "x" is missing, with no default')
  if (missing(y)) stop('argument "y" is missing, with no default')
  if (missing(type)) stop('argument "type" is missing, with no default')
  if (missing(by)) stop('argument "by" is missing, with no default')

  # check that merge type is valid
  check <- c("1:1", "m:1", "1:m", "m:m")
  if (!type %in% check) stop('argument "type" is not valid, with no default')

  # check that datasets satisfy requirements for merge type
  if (type == "1:1" & anyDuplicated(select(x, by)) != 0) stop("variable(s) does not uniquely identify observations in master")
  if (type == "1:1" & anyDuplicated(select(y, by)) != 0) stop("variable(s) does not uniquely identify observations in using")
  if (type == "1:m" & anyDuplicated(select(x, by)) != 0) stop("variable(s) does not uniquely identify observations in master")
  if (type == "m:1" & anyDuplicated(select(y, by)) != 0) stop("variable(s) does not uniquely identify observations in using")

  # merge and create equivalent of Stata _merge variable
  x$xmerge <- 1
  y$ymerge <- 2
  df <- full_join(x, y, by = by)
  df$merge <- rowSums(df[,c("xmerge", "ymerge")], na.rm=TRUE)
  df$xmerge <- NULL
  df$ymerge <- NULL
  print(table(df$merge))
  df

}
