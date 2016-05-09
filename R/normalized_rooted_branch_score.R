#' calculates the normalized rooted branch score
#' @param x, y
#' @return the normalized rooted branch score
#' @export
#' @author Femke thon

# At some point, I want to start with reading a file - but for now, let's act like x
# and y are vectors containing the lengths of the branches, in the right order. If a
# branch doesn't exist, the length defaults to 0.

normalized_rooted_branch_score <- function(x, y) {
# Startin with a few error messages
  if (any(x > 1) || any(y > 1)){
  stop("Branch lengths should be 1 or smaller.")
  }
# filling up the branches.
  if (length(x) != length(y)){
    elongate_by <- (length(y) - length(x))
    while (elongate_by > 0){
      x <- c(x, 0)
      elongate_by <- (elongate_by - 1)
    }
    elongate_by <- (length(x) - length(y))
    while (elongate_by > 0){
      y <- c(y, 0)
      elongate_by <- (elongate_by - 1)
    }
  }

  score      <- 0
  tick       <- 1
  for (i in x){
    subscore <- ((i - y[tick])^2)
    score    <- (score + subscore)
    tick     <- (tick + 1)
  }
  return(score)
}

