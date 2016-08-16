#' Determines if the input is a Cer2016 posterior,
#' @param p the first Cer2016 posterior
#' @param q the second Cer2016 posterior
#' @return TRUE or FALSE
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
#'   posterior_2 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)
#'   testit::assert( are_identical_posteriors(posterior_1, posterior_1))
#'   testit::assert(!are_identical_posteriors(posterior_1, posterior_2))
#'   testit::assert(!are_identical_posteriors(posterior_2, posterior_1))
#'   testit::assert( are_identical_posteriors(posterior_2, posterior_2))
#' @author Richel Bilderbeek
#' @export
are_identical_posteriors <- function(p, q) {

  if (!RBeast::is_posterior(p)) {
    stop(
      "are_identical_posteriors: p must be a Cer2016 posterior"
    )
  }
  if (!RBeast::is_posterior(q)) {
    stop(
      "are_identical_posteriors: ",
      "q must be a Cer2016 posterior"
    )
  }
  if (!are_identical_trees_posteriors(p$trees, q$trees)) {
    return(FALSE)
  }

  return(TRUE)
}
