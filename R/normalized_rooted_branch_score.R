#' calculates the normalized rooted branch score
#' @param x, y
#' @return the normalized rooted branch score
#' @export
#' @author Femke Thon
normalized_rooted_branch_score <- function(x, y) {
  # At some point, I want to start with reading a file - but for now, let's act
  # like x and y are vectors containing the lengths of the branches, in the right
  # order. If a branch doesn't exist, it's represented by NA.


  # starting with a few error messages
  if (length(x) != length(y)){
    stop("Vectors should be of equal length.")
  }
# filling up the positions of branches that aren't there. It has to be this
# order, because otherwise, the next error is going to complain about NA not
# being a number.
  x <- replace(x, is.na(x), 0)
  y <- replace(y, is.na(y), 0)

  if (any(x > 1) || any(y > 1)){
    stop("Branch lengths should be 1 or smaller.")
  }

# actually calculating the score
  score      <- 0
  tick       <- 1
  for (i in x){
    subscore <- ( (i - y[tick]) ^ 2)
    score    <- (score + subscore)
    tick     <- (tick + 1)
  }
  return(score)
}
