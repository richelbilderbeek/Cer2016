#' Collect the number of sampled species trees in a parameter file
#' @param filename name of the file containing the parameters and results
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return a data frame
#' @examples
#'  filename <- find_path("toy_example_1.RDa")
#'  df <- collect_n_species_trees(filename)
#'  testit::assert(names(df) == c("n_species_trees"))
#'  testit::assert(ncol(df) == 1)
#'  testit::assert(nrow(df) == 1)
#'  testit::assert(nrow(df$n_species_trees[1]) == 1)
#' @export
#' @author Richel Bilderbeek
collect_n_species_trees <- function(
  filename,
  verbose = FALSE
) {
  # Order dependency: check verbose first,
  # otherwise is_valid_file will stop
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_n_species_trees: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_n_species_trees: ",
      "invalid filename '", filename, "'"
    )
  }


  file <- Cer2016::read_file(filename)

  # pbd_output$recontree must be present, return NA if absent
  if (is.null(file) || is.null(names(file$pbd_output))
  ) {
    if (verbose) {
      print("collect_n_species_trees: file$pbd_output$recontree absent")
    }
    return(data.frame(n_species_trees = NA))
  }

  return (data.frame(n_species_trees = length(file$species_trees)))
}
