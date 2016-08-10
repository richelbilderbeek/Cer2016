#' Set an alignment of a file
#' @param file A loaded parameter file
#' @param i the index of the alignment
#' @param alignment an alignment, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_alignment_by_index <- function(
  file,
  i,
  alignment
) {
  if (i < 1) {
    stop("index must be at least 1")
  }
  if (i > length(file$alignments)) {
    stop("index must be less than number of alignments")
  }
  file$alignments[[i]] <- list(alignment)
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
    stop("sti must be at least 1")
  }
  if (sti > 2) {
    stop("sti must at most be 2")
  }
  if (ai < 1) {
    stop("ai must be at least 1")
  }
  napst <- Cer2016::extract_napst(file = file)
  if (ai > napst) {
    stop("ai must at most be napst")
  }
  if (!is_alignment(alignment)) {
    stop("alignment must be an alignment")
  }

  i <- Cer2016::a2i(sti = sti, ai = ai, nstpist = 2, napst = napst)

  return (
    set_alignment_by_index(
      file = file,
      i = i,
      alignment = alignment
    )
  )
}
