#' Determines if the input is a BEAST2 posterior,
#' as parsed by parse_beast_trees
#' @param x the input
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
is_posterior <- function(
  x,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "is_posterior: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (class(x) != "list") {
    if (verbose) {
      message("x is not a list")
    }
    return(FALSE)
  }
  for (item in x) {
    if (class(item) != "phylo") {
      if (verbose) {
        message("item in x not a phylo")
      }
      return(FALSE)
    }
  }

  valid_name_regex <- "^STATE_[[:digit:]]+$"
  valid_names <- grep(valid_name_regex, names(x), perl = TRUE, value = TRUE)
  if (length(valid_names) != length(x)) {
    if (verbose) {
      message("length of posterior does not match number of names")
    }
    return(FALSE)
  }
  values <- sub("STATE_(\\d+)", "\\1", names(x))
  if (is.unsorted(as.numeric(values))) {
    if (verbose) {
    }
    return(FALSE)
  }
  return(TRUE)
}
