#' Creates a nice knitr::table to show one or more parameter files
#' @param filenames names of the parameter files
#' @param verbose give verbose output, should be TRUE or FALSE
#' @export
#' @author Richel Bilderbeek
show_parameter_files <- function(
  filenames,
  verbose = FALSE
) {
  df <- collect_parameters(
    filenames = filenames,
    verbose = verbose
  )
  my_table <- knitr::kable(df)
  my_table
}
