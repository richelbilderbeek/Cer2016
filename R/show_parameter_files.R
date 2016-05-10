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
  }
  n_files <- length(filenames)

  #testit::assert(names(filenames[1])
  if (filenames[1])

  df <- data.frame(
    parameter = names(read_file(filenames[1])$parameters),
    stringsAsFactors = FALSE
  )

  # Disable scientific notation
  old_scipen <- getOption("scipen")
  options(scipen = 999)

  for (i in 1:n_files) {
    df <- cbind(df, as.numeric(read_file(filenames[i])$parameters[2, , 2]))
  }

  # Restore original scientific notation

  colnames(df) <- c("parameters", seq(1, n_files))
  t <- knitr::kable(df)
  options(scipen = old_scipen)
  t
}