#' Calculates the nLTT statistics from a file
#' @param filename the name of a file
#' @param dt resolution of the analysis, must be between zero and one
#' @return a distribution of nLTT statistics
#' @export
#' @examples
#'   nltt_stats <- calc_nltt_stats_from_file(
#'     filename = find_path("toy_example_1.RDa"),
#'     dt = 0.1
#'   )
#'   expected_names <- c("sti", "ai", "pi", "si", "nltt_stat")
#'   testit::assert(names(nltt_stats) == expected_names)
#' @author Richel Bilderbeek
calc_nltt_stats_from_file <- function(filename, dt) {
  file <- Cer2016::read_file(filename)

  nst <- 2 # Number of species trees
  napst <- Cer2016::extract_napst(file) # number of alignments per species tree
  nppa <- Cer2016::extract_nppa(file) # number of number of posteriors per alignment
  nspp <- Cer2016::extract_nspp(file) # number of states per posterior
  n_rows <- nst * napst * nppa * nspp


  stis <- rep(c(1, 2), each = napst * nppa * nspp)
  ais <- rep(1:napst, each = nppa * nspp, times = 2)
  pis <- rep(1:nppa, each = nspp, times = 2 * napst)
  sis <- rep(1:nspp, times = 2 * napst * nppa)

  testit::assert(n_rows == length(stis))
  testit::assert(n_rows == length(ais))
  testit::assert(n_rows == length(pis))
  testit::assert(n_rows == length(sis))

  df <- data.frame(
    sti = stis,
    ai = ais,
    pi = pis,
    si = sis,
    nltt_stat = rep(NA, n_rows)
  )

  index <- 1
  for (sti in 1:2) {
    for (ai in 1:napst) {
      for (pi in 1:nppa) {
        nltt_stats <- Cer2016::calc_nltt_stats(
          phylogeny = get_species_tree_by_index(file = file, sti = sti),
          others = get_posterior(file = file, sti = sti, ai = ai, pi = pi),
          dt = dt
        )
        testit::assert(nspp == length(nltt_stats$nltt_stat))
        testit::assert(length(nltt_stats$nltt_stat) == nrow(nltt_stats))
        df$nltt_stat[
          index:(index + nrow(nltt_stats) - 1)
        ] <- nltt_stats$nltt_stat
        index <- index + nrow(nltt_stats)
      }
    }
  }

  testit::assert(names(df) == c("sti", "ai", "pi", "si", "nltt_stat"))
  df
}
