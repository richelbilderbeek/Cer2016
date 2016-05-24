#' sorts branches for the NRBS analysis
#' @param filename name of a file
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

#' Sorts branches for the NRBS analysis
#' @param phylogeny A phylogeny of class 'phylo'
#' @return something
#' @export
#' @author Femke Thon
branch_sorter <- function(phylogeny){
  #if (tools::file_ext(filename) == "txt"){
  #if (tools::file_ext(filename) == "txt"){ # nolint thanks Richel
  #  filename           <- ape::read.tree(filename) # nolint thanks Richel
  #} # nolint thanks Richel
  #else{ # nolint thanks Richel
  #  filename           <- Cer2016::read_file(filename)$species_tree_with_outgroup[[1]][[1]] # nolint thanks Richel
  #} # nolint thanks Richel
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
