#' Determines if the input is a BEAST2 posterior,
#' as parsed by olli's rBEAST package its function beast2out.read.trees
#' @param p the first posterior
#' @param q the second posterior
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
are_identical_posteriors <- function(
  p,
  q,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "are_identical_posteriors: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_beast_posterior(p)) {
    stop(
      "are_identical_posteriors: ",
      "p must be a BEAST2 posterior"
    )
  }
  if (!is_beast_posterior(q)) {
    stop(
      "are_identical_posteriors: ",
      "q must be a BEAST2 posterior"
    )
  }
  if (length(p) != length(q)) {
    return (FALSE)
  }

  for (i in seq(1, length(p))) {
    if (!all.equal(p[[i]], q[[i]])) {
      return (FALSE)
    }
  }

  return (TRUE)
}
