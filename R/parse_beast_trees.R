#' Parses a BEAST2 .trees output file
#' @param filename name of the BEAST2 .trees output file
#' @return the phylogenies in the posterior
#' @export
#' @examples
#'   posterior <- parse_beast_trees(
#'     find_path("beast2_example_output.trees")
#'   )
#'   testit::assert(is_trees_posterior(posterior))
#' @author Richel Bilderbeek
parse_beast_trees <- function(filename) {

  if (!file.exists(filename)) {
    stop("parse_beast_trees: file absent")
  }

  posterior <- rBEAST::beast2out.read.trees(filename)

  if (length(posterior) == 1 && is.na(posterior)) {
    stop("parse_beast_trees: invalid file")
  }

  posterior
}
