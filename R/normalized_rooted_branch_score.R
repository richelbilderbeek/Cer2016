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
  files                      <- NULL
  for (filename in filenames){
    file                     <- branch_sorter(filename)
    files[[length(files)+1]] <- file
  }
  names(files)               <- filenames

# actually calculating the score
  # score      <- 0
  # tick       <- 1
  # anterior   <-
  # for (posterior in groups){
  #   subscore <- ( (posterior - anterior[tick]) ^ 2)
  #   score    <- (score + subscore)
  #   tick     <- (tick + 1)
  # }

}
