#' Creates a nice knitr::table to show one or more parameter files
#' @param filenames names of the parameter files
#' @export
#' @author Richel Bilderbeek
show_parameter_files <- function(filenames) {

  for (filename in filenames) {
    if (!file.exists(filename)) {
      stop(
        "show_parameter_file: ",
        "file '", filename, "' not found"
      )
    }
    if (!is_valid_file(filename)) {
      stop(
        "show_parameter_file: ",
        "file '", filename, "' invalid"
      )
    }
  }
  n_files <- length(filenames)
  testit::assert(is_valid_file(filenames[1]))

  parameter_names <- names(read_file(filenames[1])$parameters)

  df <- data.frame(
    parameter = parameter_names,
    stringsAsFactors = FALSE
  )

  # Disable scientific notation
  old_scipen <- getOption("scipen")
  options(scipen = 999)

  for (i in 1:n_files) {
    parameter_values <- as.numeric(
      read_file(filenames[i])$parameters[2, , 2]
    )
    df <- cbind(df, parameter_values)
  }

  # Restore original scientific notation

  colnames(df) <- c("parameters", seq(1, n_files))
  t <- knitr::kable(df)
  options(scipen = old_scipen)
  t
}