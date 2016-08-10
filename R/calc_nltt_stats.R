#' Calculate the nLTT statistic between a focal phylogeny
#' and multiple others
#' @param phylogeny the focal phylogeny
#' @param others the other phylogenies
#' @return A data frame
#' @author Richel Bilderbeek
#' @examples
#'   nltt_stats <- calc_nltt_stats(
#'     phylogeny = ape::rcoal(10),
#'     others = c(ape::rcoal(10), ape::rcoal(10))
#'   )
#'   testit::assert(names(nltt_stats) == c("id", "nltt_stat"))
#'   testit::assert(is.factor(nltt_stats$id))
#' @export
calc_nltt_stats <- function(
  phylogeny,
  others
) {
  if (!is_phylogeny(phylogeny)) {
    stop("phylogeny must be a phylogeny")
  }
  if (length(others) == 0) {
    stop("must supply others")
  }
  for (q in others) {
    if (!is_phylogeny(q)) {
      stop("others must be phylogenies")
    }
  }
  nltt_stats <- rep(x = NA, times = length(others))
  i <- 1
  for (q in others) {
    nltt_stats[i] <- nLTT::nLTTstat_exact(phylogeny, q)
    i <- i + 1
  }
  testit::assert(length(nltt_stats) == length(others))

  ids <- seq_along(nltt_stats)

  testit::assert(length(nltt_stats) == length(ids))

  df <- data.frame(
    id = ids,
    nltt_stat = nltt_stats
  )
  testit::assert(nrow(df) == length(others))

  df$id <- as.factor(df$id)
  df
}
