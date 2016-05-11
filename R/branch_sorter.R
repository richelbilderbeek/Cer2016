#' sorts branches for the NRBS analysis
#' @param tree1, tree2, the trees that are to be sorted.
#' @return a sorted tree1 and tree2
#' @author Femke Thon

branch_sorter <- function(filename){

  # tree1$edge gives in the second column the end-node number, in the 'real'
  # file maybe also the tipname. (which is what I'm assuming here.)
    table              <- cbind(filename$edge, filename$edge.length)
    filename$ordered.edges <- data.table::data.table(table, key="V2")
}
