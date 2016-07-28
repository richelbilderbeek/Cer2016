#' Convert an alignment position to an index
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param nstpist the number of species trees per incipient species tree
#' @param napst the number of alignments per species tree
#' @return the plain index
#' @examples
#'   # only index must be one
#'   testit::assert(1 == a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
#'
#'   # With only two species tree indices must be one and two
#'   testit::assert(1 == a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
#'   testit::assert(2 == a2i(sti = 2, ai = 1, nstpist = 2, napst = 1))
#'
#'   # With only two alignment indices must be one and two
#'   testit::assert(1 == a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
#'   testit::assert(2 == a2i(sti = 1, ai = 2, nstpist = 1, napst = 2))
#'
#'   # With only three species tree indices must be one to three
#'   testit::assert(1 == a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
#'   testit::assert(2 == a2i(sti = 2, ai = 1, nstpist = 2, napst = 1))
#'   testit::assert(3 == a2i(sti = 3, ai = 1, nstpist = 3, napst = 1))
#' @export
#' @author Richel Bilderbeek
a2i <- function(
  sti,
  ai,
  nstpist,
  napst
) {
  i <- 1 + (sti - 1) + ( (ai - 1) * nstpist)
  return (i)
}


#' Convert a posterior position to an index
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param pi the posterior index,
#'   the pi-th psoterior of that alignment,
#'   a value from 1 to and including
#'   the number of posteriors per alignment
#' @param nstpist the number of species trees per incipient species tree
#' @param napst the number of alignments per species tree
#' @param nppa the number of posteriors per alignment
#' @return the plain index
#' @export
#' @author Richel Bilderbeek
p2i <- function(
  sti,
  ai,
  pi,
  nstpist,
  napst,
  nppa
) {
  i <- 1 + (sti - 1) +
    ( (ai - 1) * nstpist        ) +
    ( (pi - 1) * nstpist * napst)
  return (i)
}
