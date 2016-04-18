#' Determines if the input is an alignment of type DNAbin
#' @param input The input to be testes
#' @return TRUE or FALSE
#' @export
is_alignment <- function(input) {
  # Is x a single alignment?

  return (class(input) == "DNAbin")
}