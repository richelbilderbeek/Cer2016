## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
dt <- 0.1

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- ribir::get_nltt_values(phylogenies, dt = dt)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_nltts(filename, dt = dt)
testit::assert(names(df) == c("species_tree", "t", "nltt"))
testit::assert(nrow(df) == 2 * (1 + (1 / dt)))
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_nltts(filename, dt = dt)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
)
testit::assert(nrow(df) == 880)
knitr::kable(head(df))

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_file_nltts(filename, dt = dt)
testit::assert(names(df) == c("species_tree_nltts", "posterior_nltts"))
testit::assert(
  names(df$species_tree_nltts) == c("species_tree", "t", "nltt")
)
testit::assert(names(df$posterior_nltts) == 
  c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
)
testit::assert(nrow(df$species_tree_nltts) > 0)
testit::assert(nrow(df$posterior_nltts) > 0)
knitr::kable(head(df$species_tree_nltts))
knitr::kable(head(df$posterior_nltts))

