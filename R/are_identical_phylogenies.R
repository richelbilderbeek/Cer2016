#' Determines if two phylogenies are equal
#' as parsed by olli's rBEAST package its function beast2out.read.trees
#' @param p the first phylogeny
#' @param q the second phylogeny
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
are_identical_phylogenies <- function(p, q) {
  if (!is_phylogeny(p)) {
    stop(
      "are_identical_phylogenies: ",
      "p must be a phylogeny"
    )
  }
  if (!is_phylogeny(q)) {
    stop(
      "are_identical_phylogenies: ",
      "q must be a phylogeny"
    )
  }
  return (ape::all.equal.phylo(p, q))
}
