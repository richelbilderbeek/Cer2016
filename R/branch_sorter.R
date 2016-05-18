#' sorts branches for the NRBS analysis
#' @param tree1, tree2, the trees that are to be sorted.
#' @return a sorted tree1 and tree2
#' @export
#' @author Femke Thon
branch_sorter_from_file <- function(filename){
  if (tools::file_ext(filename) == "txt"){
    return(branch_sorter(ape::read.tree(filename)))
  } else{
    return(read_file(filename)$species_tree_with_outgroup[[1]][[1]])
  }

}

branch_sorter <- function(phylogeny){
  #if (tools::file_ext(filename) == "txt"){     # nolint start
  #  filename           <- ape::read.tree(filename)
  #}
  #else{
  #  filename           <- read_file(filename)$species_tree_with_outgroup[[1]][[1]]
  #}                               # nolint end
  filename <- phylogeny
  table              <- cbind(filename$edge, filename$edge.length)
  edgeorder          <- data.table::data.table(table, key = "V2")
  edgeorder          <- edgeorder[(0 - (length(filename$tip.label) + 1)), ]
  edgeorder$V4       <- filename$tip.label
  edgeorder$V1       <- NULL
  edgeorder$V2       <- NULL
  edgeorder          <- edgeorder[order(edgeorder$V4), ]
  filename$ordered.branches <- edgeorder
  filename$branch_length    <- filename$ordered.branches$V3
  filename$taxon_name       <- filename$ordered.branches$V4
  filename
}