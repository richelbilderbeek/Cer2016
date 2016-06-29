#' Set an alignment of a file
#' @param file A loaded parameter file
#' @param alignment_index the index of the alignment
#' @param alignment an alignment, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_alignment_by_index <- function(
  file,
  alignment_index,
  alignment
) {
  if (alignment_index < 1) {
    stop("set_alignment_by_index: index must be at least 1")
  }
  if (alignment_index > length(file$alignments)) {
    stop("set_alignment_by_index: index must be less than number of alignments")
  }
  file$alignments[[alignment_index]] <- list(alignment)
  file
}

#' Set an alignment from an index from a file
#' @param file A loaded parameter file
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param alignment an alignment, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_alignment <- function(
  file, sti, ai, alignment
) {
  if (sti < 1) {
    stop("set_alignment: sti must be at least 1")
  }
  if (sti > 2) {
    stop("set_alignment: sti must at most be 2")
  }
  if (ai < 1) {
    stop("set_alignment: ai must be at least 1")
  }
  napst <- extract_napst(file = file)
  if (ai > n_apst) {
    stop("set_alignment: ai must at most be napst")
  }
  i <- 1 + ((sti - 1) * napst) + (ai - 1)
  return (
    set_alignment_by_index(
      file = file,
      alignment_index = i,
      alignment = alignment
    )
  )
}
