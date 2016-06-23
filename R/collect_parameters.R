#' Creates tidy data of all parameter files
#' @param filenames names of the parameter files
#' @param verbose give verbose output, should be TRUE or FALSE
#' @examples
#'  filenames <- c(
#'    find_path("toy_example_1.RDa"),
#'    find_path("toy_example_2.RDa"),
#'    find_path("toy_example_3.RDa")
#'  )
#'  df <- collect_parameters(filenames)
#'  testit::assert(nrow(df) == 3)
#' @export
#' @author Richel Bilderbeek
collect_parameters <- function(
  filenames,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_parameters: ",
      "verbose should be TRUE or FALSE"
    )
  }

  parameter_names <- NULL

  # Find parameter filenames
  for (filename in filenames) {
    if (!is_valid_file(filename = filename, verbose = verbose)) {
      next
    }
    file <- Cer2016::read_file(filename)
    parameter_names <- names(file$parameters)
    break
  }
  if (is.null(parameter_names)) {
    df <- data.frame(message = "No valid files supplied")
    t <- knitr::kable(df)
    return(t)
  }

  # Disable scientific notation
  old_scipen <- getOption("scipen")
  options(scipen = 999)

  # Collect the parameters
  df <- NULL
  for (filename in filenames) {
    file <- NULL
    tryCatch(
      file <- Cer2016::read_file(filename),
      error = function(msg) { } # nolint msg should be unused
    )
    if (!is.null(file)) {
      parameter_values <- as.numeric(
        file$parameters[2, , 2]
      )
      testit::assert(length(parameter_values) == length(parameter_names))
      if (is.null(df)) {
        df <- data.frame(parameter_values = parameter_values)
      } else {
        df <- cbind(df, parameter_values)
      }
    } else {
      new_col <- rep(NA, times = length(parameter_names))
      testit::assert(length(new_col) == length(parameter_names))
      if (is.null(df)) {
        df <- data.frame(parameter_values = new_col)
      } else {
        df <- cbind(df, new_col)
      }
    }
  }

  tidy_df <- t(df)
  rownames(tidy_df) <- c(basename(filenames))
  colnames(tidy_df) <- parameter_names

  # Restore original scientific notation
  options(scipen = old_scipen)

  tidy_df
}
