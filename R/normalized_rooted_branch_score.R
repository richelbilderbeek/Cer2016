#' calculates the normalized rooted branch score
#' @param filenames the filenames
#' @return the normalized rooted branch score
#' @export
#' @author Femke Thon

# At some point, I want to start with reading a file - but for now, let's act
# like x and y are vectors containing the lengths of the branches, in the same
# order. If a branch doesn't exist, it's represented by NA.

normalized_rooted_branch_score <- function(filenames) {
# sorting the trees.
  for (filename in filenames){
    filename                <- Cer2016::branch_sorter(filename)
  }
# actually calculating the score
  score      <- 0
  tick       <- 1
  PBD_output <-  # nolint variables cannot be named 'PBD-output', so I renamed it to 'PBD-output'
  for (posterior in groups){
    subscore <- ( (posterior - PBD_output[tick]) ^ 2)
    score    <- (score + subscore)
    tick     <- (tick + 1)
  }
 filename
}
