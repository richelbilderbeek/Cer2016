## ------------------------------------------------------------------------
library(ape)
library(Cer2016)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_1.RDa")
print(filename)

## ------------------------------------------------------------------------
file <- read_file(filename)

## ------------------------------------------------------------------------
print(names(file))

## ------------------------------------------------------------------------
print(names(file$pbd_output))

## ------------------------------------------------------------------------
incipient_species_tree <- file$pbd_output$igtree.extant
colors <- setNames(c("gray", "black"), c("i","g"))
phytools::plotSimmap(
  incipient_species_tree, 
  colors = colors
)

## ------------------------------------------------------------------------
true_tree <- file$species_trees_with_outgroup[[1]][[1]]
plot(true_tree)

## ------------------------------------------------------------------------
true_gamma <- gammaStat(true_tree)
print(true_gamma)
if (true_gamma < 0) {
  print("tippy tree")
} else {
  print("stemmy tree")
}  

## ------------------------------------------------------------------------
posterior_filename <- find_path("toy_example_1_1_1_1.trees")

## ------------------------------------------------------------------------
posterior_trees <- rBEAST::beast2out.read.trees(posterior_filename)
n_trees <- length(posterior_trees)
print(paste0("There are ", n_trees))

## ------------------------------------------------------------------------
for (i in seq(1:n_trees)) {
  plot(posterior_trees[[i]])
}

## ------------------------------------------------------------------------
library(ape)
phylogeny <- rcoal(10)
plot(phylogeny)

## ------------------------------------------------------------------------
measurement_1 <- runif(n = 1, max = sum(phylogeny$edge.length))
measurement_2 <- runif(n = 1, max = sum(phylogeny$edge.length))
print(measurement_1)
print(measurement_2)

