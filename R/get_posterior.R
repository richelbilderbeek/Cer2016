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
    stop("index must be at least 1")
  }
  if (i > length(file$posteriors)) {
    stop("index must be less than number of posteriors")
  }
  posterior <- file$posteriors[[i]][[1]]
  if (!RBeast::is_posterior(posterior)) {
    # The posterior may not be added yet
    stop(
      "posterior absent at index ",
      i
    )
  }
  posterior
}

#' Extract a BEAST2 posterior from a file
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
#' @examples
#'   # Read a file with one or more posteriors
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   # Pick the indices of the posterior to extract
#'   sti  <- 1 # Species tree index
#'   ai   <- 1 # Alignment index
#'   pi   <- 1 # Posterior index
#'   # Extract the posterior
#'   posterior <- get_posterior(file = file, sti = sti, ai = 1, pi = 1)
#'   # Check that it is indeed a posterior of non-zero length
#'   testit::assert(all(names(posterior) == c("trees", "estimates")))
#'   testit::assert(RBeast::is_posterior(posterior))
#'   testit::assert(length(posterior) > 0)
#' @author Richel Bilderbeek
get_posterior <- function(
  file,
  sti,
  ai,
  pi
) {
  if (sti < 1) {
    stop("sti must be at least 1")
  }
  if (sti > 2) {
    stop("sti must at most be 2")
  }
  if (ai < 1) {
    stop("ai must be at least 1")
  }
  napst <- Cer2016::extract_napst(file = file)
  if (ai > napst) {
    stop("ai must at most be napst")
  }
  if (pi < 1) {
    stop("pi must be at least 1")
  }
  nppa <- Cer2016::extract_nppa(file = file)
  if (pi > nppa) {
    stop("pi must at most be nppa")
  }

  i <- Cer2016::p2i(
    sti = sti, pi = pi, ai = ai, nstpist = 2, napst = napst, nppa = nppa
  )

  posterior <- NA
  tryCatch(
    posterior <- get_posterior_by_index(file = file, i = i),
    error = function(msg) {
      stop(msg$message)
    }
  )
  return (posterior)

}
