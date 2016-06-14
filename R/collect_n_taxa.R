#' Collects the number of taxa of all phylogenies in the
#' melted/uncast/long form
#' @param phylogenies the phylogenies, supplied as either a list or a multiPhylo object, where the phylogenies are of type 'phylo'
#' @return A dataframe of the number of taxa of each phylogeny in time
#' @author Richel Bilderbeek
#' @examples
#'   phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
#'   df <- collect_n_taxa(phylogenies)
#'   testit::assert(names(df) == c("n_taxa"))
#'   testit::assert(df == data.frame(n_taxa = c(10, 20)))
#' @export
collect_n_taxa <- function(phylogenies) {
  if (length(phylogenies) < 1) {
    stop("collect_n_taxa: ",
         "there must be at least one phylogeny supplied")
  }
  if (class(phylogenies) != "multiPhylo" && class(phylogenies) != "list") {
    stop("collect_n_taxa: ",
         "phylogenies must be of class 'multiPhylo' or 'list', ",
         "used '", class(phylogenies), "' instead")
  }
  if (!inherits(phylogenies[[1]], "phylo")) {
    # Stop imposed by ape::ltt.plot.coords
    stop("collect_n_taxa: ",
         "phylogenies must be of type phylo, ",
         "instead of '", class(phylogenies[[1]]), "'")
  }

  n_cols <- 1 # n_taxa
  n_phylogenies <- length(phylogenies)
  n_rows <- n_phylogenies
  m <- matrix(nrow = n_rows, ncol = n_cols)
  for (i in seq(1, n_phylogenies)) {
    testit::assert(i >= 1 && i <= n_phylogenies)
    n_taxa <- length(phylogenies[[i]]$tip.label)
    m[i, 1] <- n_taxa
  }
  z <- as.data.frame(x = m)
  colnames(z) <- c("n_taxa")
  z[, 1] <- sapply(z[, 1], as.integer)
  testit::assert(names(z) == c("n_taxa"))
  z
}
