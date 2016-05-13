#' Collects the gamma statistics of all phylogenies in the
#' melted/uncast/long form
#' @param phylogenies the phylogenies, supplied as either a list or a multiPhylo object, where the phylogenies are of type 'phylo'
#' @return A dataframe of gamma statistics of each phylogeny in time
#' @export
collect_gamma_statistics <- function(phylogenies) {
  if (length(phylogenies) < 1) {
    stop("collect_gamma_statistics: ",
         "there must be at least one phylogeny supplied")
  }
  if (class(phylogenies) != "multiPhylo" && class(phylogenies) != "list") {
    stop("collect_gamma_statistics: ",
         "phylogenies must be of class 'multiPhylo' or 'list', ",
         "used '", class(phylogenies), "' instead")
  }
  if (!inherits(phylogenies[[1]], "phylo")) {
    # Stop imposed by ape::ltt.plot.coords
    stop("collect_gamma_statistics: ",
         "phylogenies must be of type phylo, ",
         "instead of '", class(phylogenies[[1]]), "'")
  }

  n_cols <- 2 # ID, gamma_statistic
  n_phylogenies <- length(phylogenies)
  n_rows <- n_phylogenies
  m <- matrix(nrow = n_rows, ncol = n_cols)
  for (i in seq(1, n_phylogenies)) {
    testit::assert(i >= 1 && i <= n_phylogenies)
    gamma_stat <- ape::gammaStat(phylogenies[[i]])
    m[i, 1] <- i #
    m[i, 2] <- gamma_stat
  }
  z <- as.data.frame(x = m)
  colnames(z) <- c("id", "gamma")
  z[, 1] <- sapply(z[, 1], as.integer)
  z
}
