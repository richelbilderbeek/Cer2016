#' sorts branches for the NRBS analysis
#' @param tree1, tree2, the trees that are to be sorted.
#' @return a sorted tree1 and tree2
#' @author Femke Thon

branch_sorter <- function(anteriors, posteriors){

  # tree1$edge gives in the second column the end-node number, in the 'real'
  # file maybe also the tipname. (which is what I'm assuming here.)
  cbind(tree1$edge, tree1$edge.length)

  # filling up the positions of branches that aren't there.
  x <- replace(x, is.na(x), 0)
  y <- replace(y, is.na(y), 0)

}
