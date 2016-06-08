## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_n_taxa(phylogenies)
testit::assert(names(df) == c("n_taxa"))
testit::assert(df == data.frame(n_taxa = c(10, 20)))
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_n_taxa(filename)
testit::assert(names(df) == c("n_taxa"))
testit::assert(nrow(df) == 1)
knitr::kable(df)

## ------------------------------------------------------------------------
file <- read_file(filename)
plot(file$species_trees_with_outgroup[[1]][[1]])

## ------------------------------------------------------------------------
testit::assert(file.exists(trees_filename))
all_trees <- rBEAST::beast2out.read.trees(trees_filename)
plot(all_trees[[1]])

