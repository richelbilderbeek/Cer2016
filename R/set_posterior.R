#' Set a BEAST2 posterior of a file
#' @param file A loaded parameter file
#' @param i the index of the posterior
#' @param posterior a BEAST2 posterior, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_posterior_by_index <- function(file, i, posterior) {
  if (i < 1) {
    stop("set_posterior_by_index: index must be at least 1")
  }
  if (i > length(file$posteriors)) {
    stop("set_posterior_by_index: index must be less than number of posteriors")
  }
  file$posteriors[[i]] <- list(posterior)
  file
}

#' Set an posterior to a file
#' @param file A loaded parameter file
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param alignment an alignment, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_posterior <- function(
  file, sti, ai, pi, posterior
) {
  if (sti < 1) {
    stop("set_posterior: sti must be at least 1")
  }
  if (sti > 2) {
    stop("set_posterior: sti must at most be 2")
  }
  if (ai < 1) {
    stop("set_posterior: ai must be at least 1")
  }
  napst <- extract_napst(file = file)
  if (ai > napst) {
    stop("set_posterior: ai must at most be napst")
  }
  if (!is_posterior(posterior)) {
    stop("set_posterior: posterior must be an posterior")
  }
  if (pi < 1) {
    stop("set_posterior: pi must be at least 1")
  }
  nppa <- extract_nppa(file = file)
  if (pi > nppa) {
    stop("set_posterior: pi must at most be nppa")
  }
  if (!is_posterior(posterior)) {
    stop("set_posterior: posterior must be a posterior")
  }

  i <- 1 + (pi - 1) +
    ((ai - 1) * napst) +                                            # nolint
    ((sti - 1) * napst * 2)

  return (
    set_posterior_by_index(
      file = file,
      i = i,
      posterior = posterior
    )
  )
}
