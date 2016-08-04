#' Determines if the input is a Cer2016 posterior,
#' @param p the first Cer2016 posterior
#' @param q the second Cer2016 posterior
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
  if (!is_posterior(p)) {
    stop(
      "are_identical_posteriors: ",
      "p must be a Cer2016 posterior"
    )
  }
  if (!is_posterior(q)) {
    stop(
      "are_identical_posteriors: ",
      "q must be a Cer2016 posterior"
    )
  }
  if (!are_identical_trees_posteriors(p$trees, q$trees)) {
    return (FALSE)
  }

  return (TRUE)
}
