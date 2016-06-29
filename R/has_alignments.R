#' Checks if alignments are present
#' @return a vector of TRUEs and FALSEs
#' @author Richel Bilderbeek
#' @export
has_alignments <- function(file) {

  n_alignments <- as.numeric(file$parameters$n_alignments[2])

  v <- NULL

  for (sti in 1:2) {
    for (j in 1:n_alignments) {
      alignment_index <- 1 + (sti - 1) + ((j - 1) * 2)
      alignment <- NA
      tryCatch(
        alignment <- get_alignment_by_index(
          file = file,
          alignment_index = alignment_index
        ),
        error = function(msg) {}
      )
      v <- c(v, is_alignment(alignment))
    }
  }
  v
}
