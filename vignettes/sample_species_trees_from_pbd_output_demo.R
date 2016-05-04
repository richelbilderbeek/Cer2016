## ------------------------------------------------------------------------
library(Cer2016)
library(ggplot2)
library(phytools)
library(ribir)

## ------------------------------------------------------------------------
age <- 10
seed <- 320
set.seed(seed)

species_initiation_rate_good_species  <- 0.7
speciation_completion_rate <- 0.2
species_initiation_rate_incipient_species <- 0.6
extinction_rate_good_species <- 1.0
extinction_rate_incipient_species <- 0.6

# Work on the pbd_sim output
pbd_sim_output <- PBD::pbd_sim(
  c(
    species_initiation_rate_good_species = species_initiation_rate_good_species,
    speciation_completion_rate = speciation_completion_rate,
    species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,
    extinction_rate_good_species = extinction_rate_good_species,
    extinction_rate_incipient_species = extinction_rate_incipient_species
  ),
  age, plotit = TRUE
)
testit::assert(is_pbd_sim_output(pbd_sim_output))

## ------------------------------------------------------------------------
cols = setNames(c("gray", "black"), c("i", "g"))
phytools::plotSimmap(pbd_sim_output$igtree.extant, colors = cols)

## ------------------------------------------------------------------------
n <- 10
species_trees <- sample_species_trees_from_pbd_sim_output(n = n, pbd_sim_output)
for (species_tree in species_trees) {
  plot(species_tree)
}

## ------------------------------------------------------------------------
df <- get_nltt_values(species_trees, dt = 0.01)
ggplot2::qplot(t, nltt, data = df, geom = "blank", ylim = c(0, 1), main = "Average nLTT plot of phylogenies") + 
  ggplot2::stat_summary(fun.data = "mean_cl_boot", color = "red", geom = "smooth")

## ------------------------------------------------------------------------
set.seed(seed)
species_tree_a <- sample_species_trees_from_pbd_sim_output(n = n, pbd_sim_output)[[1]]
set.seed(seed)
species_tree_b <- sample_species_trees_from_pbd_sim_output(n = n, pbd_sim_output)[[1]]
plot(species_tree_a, main = "A")
plot(species_tree_b, main = "B")

## ------------------------------------------------------------------------
set.seed(seed + 1)
species_tree_c <- sample_species_trees_from_pbd_sim_output(n = n, pbd_sim_output)[[1]]
plot(species_tree_c, main = "C")

