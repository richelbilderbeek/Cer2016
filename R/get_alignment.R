#' Extract an alignment from an index from a file
#' @param file A loaded parameter file
#' @param alignment_index the index of the alignment
#' @return the alignment
#' @export
#' @author Richel Bilderbeek
get_alignment_by_index <- function(
  file,
  alignment_index
) {
  if (alignment_index < 1) {
    stop("get_alignment_by_index: index must be at least 1")
  }
  if (alignment_index > length(file$alignments)) {
    stop("get_alignment_by_index: index must be less than number of alignments")
  }

  alignment <- file$alignments[[alignment_index]][[1]]
  if (!Cer2016::is_alignment(alignment)) {
    # The alignment may not be added yet
    stop(
      "get_alignment_by_index: alignment absent at index ",
      alignment_index
    )
  }
  alignment
}

#' Extract an alignment from an index from a file
#' @param file A loaded parameter file
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @return the alignment
#' @export
#' @author Richel Bilderbeek
get_alignment <- function(
  file, sti, ai
) {
  if (sti < 1) {
    stop("get_alignment: sti must be at least 1")
  }
  if (sti > 2) {
    stop("get_alignment: sti must at most be 2")
  }
  if (ai < 1) {
    stop("get_alignment: ai must be at least 1")
  }
  napst <- extract_napst(file = file)
  if (ai > n_apst) {
    stop("get_alignment: ai must at most be napst")
  }
  i <- 1 + ((sti - 1) * napst) + (ai - 1)
  return (get_alignment_by_index(
      file = file,
      alignment_index = i
    )
  )
}
