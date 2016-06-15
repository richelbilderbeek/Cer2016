#' Collect the number of taxa of the species trees
#' @param filename name of the file containing the parameters and results
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return a data frame
#' @examples
#'  filename <- find_path("toy_example_1.RDa")
#'  df <- collect_species_tree_n_taxa(filename)
#'  testit::assert(names(df) == c("n_taxa"))
#'  testit::assert(ncol(df) == 1)
#'  testit::assert(nrow(df) == 1)
#'  testit::assert(df$n_taxa[1] > 0)
#' @export
#' @author Richel Bilderbeek
collect_species_tree_n_taxa <- function(
  filename,
  verbose = FALSE
) {
  # Order dependency: check verbose first,
  # otherwise is_valid_file will stop
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_species_n_taxa: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_species_n_taxa: ",
      "invalid filename '", filename, "'"
    )
  }


  file <- Cer2016::read_file(filename)

  # pbd_output$recontree must be present, return NA if absent
  if (is.null(file) || is.null(names(file$pbd_output))
  ) {
    if (verbose) {
      print("collect_species_n_taxa: file$pbd_output absent")
    }
    return(data.frame(n_taxa = NA))
  }

  # pbd_output$recontree must be a phylogeny, return NA if not
  phylogeny <- file$pbd_output$recontree
  testit::assert(inherits(phylogeny, "phylo"))

  # phylogeny must be put in a list or vector
  g <- Cer2016::collect_n_taxa(list(phylogeny))
  return (data.frame(n_taxa = g$n_taxa))
}
