#' Parses BEAST2 output files to a Cer2016 posterior
#' @param trees_filename name of the BEAST2 .trees output file
#' @param log_filename name of the BEAST2 .trees output file
#' @return a Cer2016 posterior
#' @export
#' @examples
#'   posterior <- parse_beast_posterior(
#'     trees_filename = find_path("beast2_example_output.trees"),
#'     log_filename = find_path("beast2_example_output.log")
#'   )
#'   testit::assert(is_posterior(posterior))
#' @author Richel Bilderbeek
parse_beast_posterior <- function(trees_filename, log_filename) {

  if (!file.exists(trees_filename)) {
    stop("parse_beast_posterior: trees_filename absent")
  }

  if (!file.exists(log_filename)) {
    stop("parse_beast_posterior: log_filename absent")
  }

  posterior_trees <- parse_beast_trees(trees_filename)
  posterior_estimates <- parse_beast_log(log_filename)

  posterior <- list(
    trees = posterior_trees,
    estimates = posterior_estimates
  )
  testit::assert(is_posterior(posterior))
  posterior
}
