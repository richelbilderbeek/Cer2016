#' Parses a BEAST2 .log output file
#' @param filename name of the BEAST2 .log output file
#' @return data frame with all the parameter estimates
#' @export
#' @examples
#'   estimates <- parse_beast_log(
#'     find_path("beast2_example_output.log")
#'   )
#'   expected_names <- c(
#'     "Sample", "posterior", "likelihood",
#'     "prior", "treeLikelihood", "TreeHeight",
#'     "BirthDeath", "birthRate2", "relativeDeathRate2"
#'   )
#'   testit::assert(names(estimates) == expected_names)
#' @author Richel Bilderbeek
parse_beast_log <- function(filename) {
  if (!file.exists(filename)) {
    stop("parse_beast_log: file absent")
  }
  estimates <- utils::read.csv(
    file = filename,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = NULL,
    sep = "\t",
    comment.char = "#"
  )
  # Remove a column with the name X, no idea where it comes from
  estimates <- estimates[, !(names(estimates) %in% c("X"))]
  estimates
}
