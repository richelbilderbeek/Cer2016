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
    stop(
      "show_parameter_files: ",
      "not a single valid file supplied"
    )
  }

  # Collect the parameters

  # Disable scientific notation
  old_scipen <- getOption("scipen")
  options(scipen = 999)

  for (filename in filenames) {
    file <- NULL
    tryCatch(
      file <- read_file(filename),
      error = function(msg) { print(paste0("show_parameter_files: ", msg)) }
    )
    if (!is.null(file)) {
      parameter_values <- as.numeric(
        file$parameters[2, , 2]
      )
      df <- cbind(df, parameter_values)
    } else {
      df <- cbind(df, rep(NA, times = nrow(df)))
    }
  }

  # Restore original scientific notation
  colnames(df) <- c("parameters", seq(1, ncol(df) - 1))
  t <- knitr::kable(df)
  options(scipen = old_scipen)
  t
}