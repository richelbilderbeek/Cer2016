#' Calculates the Normalized Rooted Branch Score (NRBS)
#' @param phylogeny1 the first phylogeny of type 'phylo'
#' @param phylogeny2 the other phylogeny of type 'phylo'
#' @return the normalized rooted branch score
#' @export
#' @author Richel Bilderbeek
nrbs <- function(phylogeny1, phylogeny2) {
  if (class(phylogeny1) != "phylo") {
    stop(
      "nrbs: ",
      "parameter 'phylogeny1' must be of type 'phylo', ",
      "instead of type", class(phylogeny1)
    )
  }
  if (class(phylogeny2) != "phylo") {
    stop(
      "nrbs: ",
      "parameter 'phylogeny2' must be of type 'phylo', ",
      "instead of type", class(phylogeny2)
    )
  }

  difference <- 0

  difference
}
