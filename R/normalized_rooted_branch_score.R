#' calculates the normalized rooted branch score
#' @param x, y
#' @return the normalized rooted branch score
#' @export
#' @author Femke Thon

# At some point, I want to start with reading a file - but for now, let's act
# like x and y are vectors containing the lengths of the branches, in the same
# order. If a branch doesn't exist, it's represented by NA.

normalized_rooted_branch_score <- function(filenames) {
# preparing the trees
  for (filename in filenames){
    filename <- branch_sorter(filename)
  }

# actually calculating the score
  score      <- 0
  tick       <- 1
  for (branch in tree1){
    subscore <- ( (branch - tree2[tick]) ^ 2) #nolint WARNING: tree2 does not exist
    score    <- (score + subscore)
    tick     <- (tick + 1)
  }
  return(score)
}
