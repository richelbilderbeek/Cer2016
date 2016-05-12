#' Creates a nice knitr::table to show one or more parameter files
#' @param filenames names of the parameter files
#' @export
#' @author Richel Bilderbeek
show_parameter_files <- function(filenames) {

  df <- NULL

  # Find parameter filenames
  for (filename in filenames) {
    if (!file.exists(filename)) {
      next
    }
    if (!is_valid_file(filename)) {
      next
    }
    file <- read_file(filename)
    parameter_names <- names(file$parameters)
    df <- data.frame(
      parameter = parameter_names,
      stringsAsFactors = FALSE
    )
    break
  }
  if (is.null(df)) {
    df <- data.frame(message = "No valid files supplied")
    t <- knitr::kable(df)
    return(t)
  }

  # Collect the parameters

  # Disable scientific notation
  old_scipen <- getOption("scipen")
  options(scipen = 999)

  for (filename in filenames) {
    file <- NULL
    tryCatch(
      file <- read_file(filename),
      error = function(msg) { } # nolint msg should be unused
    )
    if (!is.null(file)) {
      parameter_values <- as.numeric(
        file$parameters[2, , 2]
      )
      testit::assert(length(parameter_values) == nrow(df))
      df <- cbind(df, parameter_values)
    } else {
      new_col <- rep(NA, times = nrow(df))
      testit::assert(length(new_col) == nrow(df))
      df <- cbind(df, new_col)
    }
  }

  # Restore original scientific notation
  colnames(df) <- c("parameters", basename(filenames))
  t <- knitr::kable(df)
  options(scipen = old_scipen)
  t
}
