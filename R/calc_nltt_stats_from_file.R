#' Calculates the nLTT statistics from a file
#' @param filename the name of a file
#' @return a distribution of nLTT statistics
calc_nltt_stats_from_file <- function(filename) {

  nltt_stats <- calc_nltt_stats(
    phylogeny = species_tree,
    others = posteriors,
    dt = dt
  )

  testit::assert(names(df) == c("sti", "ai", "pi", "si", "nltt_stat")
}
