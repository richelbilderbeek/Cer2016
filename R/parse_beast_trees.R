#' Parses a BEAST2 .trees output file
#' @param filename name of the BEAST2 .trees output file
#' @return the phylogenies in the posterior
#' @export
#' @examples
#'   posterior <- parse_beast_trees(find_path("toy_example_1.RDa"))
#'   testit::assert(is_posterior(posterior))
#' @author Richel Bilderbeek
parse_beast_trees <- function(filename) {
  posterior <- rBEAST::beast2out.read.trees(filename)
  posterior
}
