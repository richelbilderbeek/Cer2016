#' sorts branches for the NRBS analysis
#' @param tree1, tree2, the trees that are to be sorted.
#' @return a sorted tree1 and tree2
#' @export
#' @author Femke Thon

branch_sorter <- function(filename){
  # filename gives in the second column the end-node number, which matches the
  # order of the node-names. I'm assuming this also works in the 'real' files
  # with the tipnames, but I'm not sure.
    table              <- cbind(filename$edge, filename$edge.length)
    edgeorder          <- data.table::data.table(table, key = "V2")
    edgeorder          <- edgeorder[(0 - (length(filename$tip.label) + 1)),]
    edgeorder$V4       <- filename$tip.label
    edgeorder$V1       <- NULL
    edgeorder$V2       <- NULL
    edgeorder          <- edgeorder[order(edgeorder$V4),]
    filename$ordered.branches <- edgeorder
    filename$branch_length    <- filename$ordered.branches$V3
    filename$taxon_name       <- filename$ordered.branches$V4
    filename
}

