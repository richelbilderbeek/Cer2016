#' Obtain the crown age of a phylony
#' @param phylogeny The phylogeny to obtain the crown age of
#' @return the age of the phylogeny
#' @export
#' @author Richel Bilderbeek
get_phylogeny_crown_age <- function(
  phylogeny
) {
  n_taxa <- length(phylogeny$tip.label)
  crown_age <- ape::dist.nodes(phylogeny)[n_taxa + 1][1]
  return(crown_age)
}