#' Calculate the nLTT statistic between a focal phylogeny
#' and multiple others
#' @param phylogeny the focal phylogeny
#' @param others the other phylogenies
#' @param dt resolution of the analysis, must be between zero and one
#' @return A data frame
#' @author Richel Bilderbeek
#' @examples
#'   nltt_stats <- calc_nltt_stats(
#'     phylogeny = ape::rcoal(10),
#'     others = c(ape::rcoal(10), ape::rcoal(10)),
#'     dt = 0.1
#'   )
#'   testit::assert(names(nltt_stats) == c("id", "nltt_stat"))
#' @export
calc_nltt_stats <- function(
  phylogeny,
  others,
  dt
) {
  if (!is_phylogeny(phylogeny)) {
    stop("nltt_stats: phylogeny must be a phylogeny")
  }
  if (length(others) == 0) {
    stop("nltt_stats: must supply others")
  }
  for (phylogeny in others) {
    if (!is_phylogeny(phylogeny)) {
      stop("nltt_stats: others must be phylogenies")
    }
  }
  if (dt <= 0.0) {
    stop("nltt_stats: dt must be more than zero")
  }
  if (dt >= 1.0) {
    stop("nltt_stats: dt must be less than one")
  }

  phylogeny_nltts <- nLTT::get_nltt_values(
   phylogenies = c(phylogeny),
   dt = dt
  )
  other_nltts <- nLTT::get_nltt_values(
   phylogenies = others,
   dt = dt
  )
  diff_nltts <- other_nltts

  # Calculate the difference between the two lines
  # (which are the species
  # tree nLTT values and each posterior nLTT values):
  diff_nltts$nltt <- abs(diff_nltts$nltt -
    rep(phylogeny_nltts$nltt, length(others)))

  id <- NULL; rm(id) # nolint, should fix warning: calc_nltt_stats: no visible binding for global variable 'id'
  nltt <- NULL; rm(nltt) # nolint, should fix warning: calc_nltt_stats: no visible binding for global variable 'nltt'

  # Calculate the surface between the two lines (which are the species
  # tree nLTT values and each posterior nLTT values):
  # the mean is taken as a trick to sum all differences
  # and divide by the number of differences
  nltt_stats <- dplyr::summarize(
    dplyr::group_by(diff_nltts, id), nltt_stat = mean(nltt)
  )
  nltt_stats
}
