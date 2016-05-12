#' Creates tidy data of all parameter files
#' @param filenames names of the parameter files
#' @param verbose give verbose output, should be TRUE or FALSE
#' @examples
#'  filenames <- c(
#'    find_path("article_0_0_0_0_0.RDa"),
#'    find_path("article_0_1_4_0_2.RDa"),
#'    find_path("toy_example_1.RDa")
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
      "show_parameter_files: ",
      "verbose should be TRUE or FALSE"
    )
  }

  row_names <- NULL

  # Find parameter filenames
  for (filename in filenames) {
    if (!is_valid_file(filename = filename, verbose = verbose)) {
      next
    }
    file <- read_file(filename)
    parameter_names <- names(file$parameters)
    row_names <- parameter_names
    break
  }
  if (is.null(row_names)) {
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
      file <- read_file(filename),
      error = function(msg) { } # nolint msg should be unused
    )
    if (!is.null(file)) {
      parameter_values <- as.numeric(
        file$parameters[2, , 2]
      )
      testit::assert(length(parameter_values) == length(row_names))
      if (is.null(df)) {
        df <- data.frame(parameter_values = parameter_values)
      } else {
        df <- cbind(df, parameter_values)
      }
    } else {
      new_col <- rep(NA, times = length(row_names))
      testit::assert(length(new_col) == length(row_names))
      if (is.null(df)) {
        df <- data.frame(parameter_values = new_col)
      } else {
        df <- cbind(df, new_col)
      }
    }
  }

  rownames(df) <- row_names
  colnames(df) <- c(basename(filenames))
  tidy_df <- t(df)

  # Restore original scientific notation
  options(scipen = old_scipen)

  tidy_df
}
