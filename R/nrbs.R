#' Calculates the Normalized Rooted Branch Score (NRBS)
#' @param phylogeny1 the first phylogeny of type 'phylo'
#' @param phylogeny2 the other phylogeny of type 'phylo'
#' @return the normalized rooted branch score
#' @details
#'   The NRBS 'is the rooted equivalent of the branch score metric suggested
#'   by Kuhner and Felsenstein' (quoted from Heled & Drummond, 2010).
#'   phangorn::KF.dist returns by default the unrooted value,
#'   but can be changed to return the rooted value
#' @author Richel Bilderbeek
#' @references
#'   Heled, Joseph, and Alexei J. Drummond. "Bayesian inference of species trees from multilocus data." Molecular biology and evolution 27.3 (2010): 570-580.
#'   Kuhner, Mary K., and Joseph Felsenstein. "A simulation comparison of phylogeny algorithms under equal and unequal evolutionary rates." Molecular Biology and Evolution 11.3 (1994): 459-468.
#' @export
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

  # KF.dist return the branch score distance (Kuhner & Felsenstein 1994)
  difference <- phangorn::KF.dist(
    phylogeny1,
    phylogeny2,
    check.labels = TRUE,
    rooted = TRUE
  )
  difference
}
