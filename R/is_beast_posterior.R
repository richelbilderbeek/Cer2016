#' Determines if the input is a BEAST2 posterior
#' @param x the input
#' @return TRUE or FALSE
#' @export
#' @author Richel Bilderbeek
is_beast_posterior <- function(x) {
  # as parsed by olli's rBEAST package its function beast2out.read.trees
  if (class(x) != "list") {
    return(FALSE)
  }
  for (item in x) {
    if (class(item) != "phylo") return(FALSE)
  }

  valid_name_regex <- "^STATE_[[:digit:]]+$"
  valid_names <- grep(valid_name_regex, names(x), perl = TRUE, value = TRUE)
  if (length(valid_names) != length(x)) {
    return(FALSE)
  }
  values <- sub("STATE_(\\d+)", "\\1", names(x))
  if (is.unsorted(as.numeric(values))) {
    return(FALSE)
  }
  return(TRUE)
}