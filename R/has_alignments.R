#' Checks if alignments are present
#' @param file a file, as returned by 'read_file(filename)'
#' @return a vector of TRUEs and FALSEs
#' @author Richel Bilderbeek
#' @export
has_alignments <- function(file) {

  n_alignments <- as.numeric(file$parameters$n_alignments[2])

  v <- NULL

  for (sti in 1:2) {
    for (ai in 1:n_alignments) {
      alignment <- NA
      tryCatch(
        alignment <- get_alignment(
          file = file,
          sti = sti,
          ai = ai
        ),
        error = function(msg) {} # nolint
      )
      v <- c(v, Cer2016::is_alignment(alignment))
    }
  }
  v
}
