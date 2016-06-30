#' Extract a BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @param i the posterior index,
#'   the index of the posteriors in the list of posteriors
#' @return the posterior
#' @export
#' @author Richel Bilderbeek
get_posterior_by_index <- function(file, i) {
  if (i < 1) {
    stop("get_posterior_by_index: index must be at least 1")
  }
  if (i > length(file$posteriors)) {
    stop("get_posterior_by_index: index must be less than number of posteriors")
  }
  posterior <- file$posteriors[[i]][[1]]
  if (!Cer2016::is_posterior(posterior)) {
    # The posterior may not be added yet
    stop(
      "get_posterior_by_index: posterior absent at index ",
      i
    )
  }
  posterior
}

#' Extract a BEAST2 posterior
#'   from a file
#' @param file A loaded parameter file
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param pi the posterior index,
#'   the pi-th posterior of that alignment,
#'   a value from 1 to and including
#'   the number of posteriors per alignment
#' @return the posterior
#' @export
#' @author Richel Bilderbeek
get_posterior <- function(
  file,
  sti,
  ai,
  pi
) {
  if (sti < 1) {
    stop("get_posterior: sti must be at least 1")
  }
  if (sti > 2) {
    stop("get_posterior: sti must at most be 2")
  }
  if (ai < 1) {
    stop("get_posterior: ai must be at least 1")
  }
  napst <- extract_napst(file = file)
  if (ai > napst) {
    stop("get_posterior: ai must at most be napst")
  }
  if (pi < 1) {
    stop("get_posterior: pi must be at least 1")
  }
  nppa <- extract_nppa(file = file)
  if (ai > nppa) {
    stop("get_posterior: pi must at most be nppa")
  }

  i <- p2i(sti = sti, pi = pi, ai = ai, nstpist = 2, napst = napst, nppa = nppa)

  posterior <- NA
  tryCatch(
    posterior <- get_posterior_by_index(file = file, i = i),
    error = function(msg) {
      stop("get_posterior: ", msg$message)
    }
  )
  return (posterior)

}
