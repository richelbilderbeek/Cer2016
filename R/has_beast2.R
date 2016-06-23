#' Determines if BEAST2 is installed
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
has_beast2 <- function(
) {
  beast_path <- NA
  tryCatch(
    beast_path <- find_beast_jar_path(),
    error = function(msg) {

    }
  )
  return (!is.na(beast_path))
}
