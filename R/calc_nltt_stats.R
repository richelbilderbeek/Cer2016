#' Calculate the nLTT statistic between a focal phylogeny
#' and multiple others
#' @param phylogeny the focal phylogeny
#' @param others the other phylogenies
#' @param dt resolution of the analysis, must be between zero and one
#' @return A data frame
#' @author Richel Bilderbeek
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
  diff_nltts$nltt <- abs(diff_nltts$nltt - rep(phylogeny_nltts$nltt, length(others)))
  nltt_stats <- dplyr::summarize(dplyr::group_by(diff_nltts, id), nltt_stat = mean(nltt))
  nltt_stats
}
