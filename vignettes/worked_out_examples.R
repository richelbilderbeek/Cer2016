<<<<<<< HEAD
## ------------------------------------------------------------------------
library(ape)
library(Cer2016)
library(ggplot2)
library(nLTT)
library(ribir)
library(phangorn)

## ------------------------------------------------------------------------
dt <- 0.001

## ------------------------------------------------------------------------
filenames = c(
  "toy_example_1.RDa", 
  "toy_example_2.RDa", 
  "toy_example_3.RDa", 
  "toy_example_4.RDa"
)

## ------------------------------------------------------------------------
#for (filename in filenames) {
#  if (file.exists(filename)) {
#    file.remove(filename)
#  }
#}

## ------------------------------------------------------------------------
rng_seeds <- seq(1,4)
sirgs <- rep(0.5, times = 4)
siris <- rep(0.5, times = 4)
scrs <- c(1.0e6, 1.0e-1, 1.0e6, 1.0e-1)
ergs <- rep(0.1, times = 4)
eris <- rep(0.1, times = 4)
ages <- rep(5, times = 4)
n_species_trees_sampleses <- c(1, 1, 2, 2)
mutation_rates <- rep(0.01, times = 4)
n_alignmentses <- c(1, 1, 2, 2)
sequence_lengths <- rep(1000, times = 4)
mcmc_chainlengths <- rep(10000, times = 4)
n_beast_runses <- c(1, 1, 2, 2)
for (i in seq(1, 4)) {
  save_parameters_to_file(
    rng_seed = rng_seeds[i],
    sirg = sirgs[i],
    siri = siris[i],
    scr = scrs[i],
    erg = ergs[i],
    eri = eris[i],
    age = ages[i],
    n_species_trees_samples = n_species_trees_sampleses[i],
    mutation_rate = mutation_rates[i],
    n_alignments = n_alignmentses[i],
    sequence_length = sequence_lengths[i],
    mcmc_chainlength = mcmc_chainlengths[i],
    n_beast_runs = n_beast_runses[i],
    filename = filenames[i]
  )  
}

## ------------------------------------------------------------------------
show_parameter_files(filenames)

## ------------------------------------------------------------------------
filename <- filenames[1]
testit::assert(is_valid_file(filename))
add_pbd_output(filename)

## ------------------------------------------------------------------------
colors <- setNames(c("gray","black"),c("i","g"))
testit::assert(length(read_file(filename)$pbd_output$igtree.extant$tip.label) > 0)
phytools::plotSimmap(
  read_file(filename)$pbd_output$igtree.extant, 
  colors = colors
)

## ------------------------------------------------------------------------
# using the `ribir` package its `get_nltt_values` function and `ggplot2`
nltt_values <- get_nltt_values(
  phylogenies = list(read_file(filename)$pbd_output$tree), 
  dt = 0.001
)
qplot(
  t, nltt, data = nltt_values, geom = "blank", ylim = c(0,1),
  main = "Example #1"
) + stat_summary(
  fun.data = "mean_cl_boot", color = "red", geom = "smooth"
)

# using the `nLTT` package its `nLTT.plot` function
nLTT::nLTT.plot(read_file(filename)$pbd_output$tree)

## ------------------------------------------------------------------------
add_species_trees_with_outgroup(filename)  

## ------------------------------------------------------------------------
plot_species_tree_with_outgroup(filename)

## ------------------------------------------------------------------------
add_alignments(filename)  

## ------------------------------------------------------------------------
plot_alignments(filename)

## ------------------------------------------------------------------------
add_posteriors(filename, skip_if_output_present = TRUE)

## ------------------------------------------------------------------------
trees_filename <- "toy_example_1_1_1_1.trees"

testit::assert(file.exists(trees_filename))

phylogenies <- rBEAST::beast2out.read.trees(trees_filename)

# To get the densiTree function working, phylogenies must be of class multiphylo
class(phylogenies) <- "multiPhylo"

densiTree(
  phylogenies, 
  type = "cladogram", 
  alpha = 1/length(phylogenies), 
  consensus = NULL, 
  optim = FALSE, 
  scaleX = FALSE, 
  col = 1, 
  width = 1, 
  cex = 0.8
)

## ------------------------------------------------------------------------
plot_species_tree_with_outgroup(filename)
plot_species_tree_with_outgroup_nltt(filename, dt = dt)

## ------------------------------------------------------------------------
plot_posterior_samples(filename)

## ------------------------------------------------------------------------
true_gamma_statistics <- collect_species_tree_gammas(filename = filename)
knitr::kable(head(true_gamma_statistics))

## ------------------------------------------------------------------------
posterior_gamma_statistics <- collect_posterior_gammas(
  filename = filename
)
knitr::kable(head(posterior_gamma_statistics))

## ------------------------------------------------------------------------
true_nltt_values <- collect_species_tree_nltts(filename = filename, dt = dt)
knitr::kable(head(true_nltt_values))

## ------------------------------------------------------------------------
posterior_nltt_values <- collect_posterior_nltt_values(
  filename = filename, dt = dt
)
knitr::kable(head(posterior_nltt_values))

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = posterior_nltt_values,
  ggplot2::aes(t, nltt),
  main = "nLTT plots"
) + ggplot2::geom_point(
  color = "transparent"
) + ggplot2::scale_x_continuous(
  limits = c(0, 1)
) + ggplot2::scale_y_continuous(
  limits = c(0, 1)
) + ggplot2::stat_summary(
  fun.data = "mean_cl_boot", size = 0.5, lty = "dashed",
  color = I("black"), geom = "smooth"
) + ggplot2::geom_step(
  data = true_nltt_values,
  ggplot2::aes(t, nltt)
)

## ------------------------------------------------------------------------
library(Cer2016)
filename <- "toy_example_4.RDa"
file <- read_file(filename)

=======
## ------------------------------------------------------------------------
library(ape)
library(Cer2016)
library(ggplot2)
library(nLTT)
library(ribir)
library(phangorn)

## ------------------------------------------------------------------------
dt <- 0.001

## ------------------------------------------------------------------------
filenames = c(
  "toy_example_1.RDa", 
  "toy_example_2.RDa", 
  "toy_example_3.RDa", 
  "toy_example_4.RDa"
)

## ------------------------------------------------------------------------
#for (filename in filenames) {
#  if (file.exists(filename)) {
#    file.remove(filename)
#  }
#}

## ------------------------------------------------------------------------
rng_seeds <- seq(1,4)
sirgs <- rep(0.5, times = 4)
siris <- rep(0.5, times = 4)
scrs <- c(1.0e6, 1.0e-1, 1.0e6, 1.0e-1)
ergs <- rep(0.1, times = 4)
eris <- rep(0.1, times = 4)
ages <- rep(5, times = 4)
n_species_trees_sampleses <- c(1, 1, 2, 2)
mutation_rates <- rep(0.01, times = 4)
n_alignmentses <- c(1, 1, 2, 2)
sequence_lengths <- rep(1000, times = 4)
mcmc_chainlengths <- rep(10000, times = 4)
n_beast_runses <- c(1, 1, 2, 2)
for (i in seq(1, 4)) {
  save_parameters_to_file(
    rng_seed = rng_seeds[i],
    sirg = sirgs[i],
    siri = siris[i],
    scr = scrs[i],
    erg = ergs[i],
    eri = eris[i],
    age = ages[i],
    n_species_trees_samples = n_species_trees_sampleses[i],
    mutation_rate = mutation_rates[i],
    n_alignments = n_alignmentses[i],
    sequence_length = sequence_lengths[i],
    mcmc_chainlength = mcmc_chainlengths[i],
    n_beast_runs = n_beast_runses[i],
    filename = filenames[i]
  )  
}

## ------------------------------------------------------------------------
show_parameter_files(filenames)

## ------------------------------------------------------------------------
filename <- filenames[1]
testit::assert(is_valid_file(filename))
add_pbd_output(filename)

## ------------------------------------------------------------------------
colors <- setNames(c("gray","black"),c("i","g"))
testit::assert(length(read_file(filename)$pbd_output$igtree.extant$tip.label) > 0)
phytools::plotSimmap(
  read_file(filename)$pbd_output$igtree.extant, 
  colors = colors
)

## ------------------------------------------------------------------------
# using the `ribir` package its `get_nltt_values` function and `ggplot2`
nltt_values <- get_nltt_values(
  phylogenies = list(read_file(filename)$pbd_output$tree), 
  dt = 0.001
)
qplot(
  t, nltt, data = nltt_values, geom = "blank", ylim = c(0,1),
  main = "Example #1"
) + stat_summary(
  fun.data = "mean_cl_boot", color = "red", geom = "smooth"
)

# using the `nLTT` package its `nLTT.plot` function
nLTT::nLTT.plot(read_file(filename)$pbd_output$tree)

## ------------------------------------------------------------------------
add_species_trees_with_outgroup(filename)  

## ------------------------------------------------------------------------
plot_species_tree_with_outgroup(filename)

## ------------------------------------------------------------------------
add_alignments(filename)  

## ------------------------------------------------------------------------
plot_alignments(filename)

## ------------------------------------------------------------------------
add_posteriors(filename, skip_if_output_present = TRUE)

## ------------------------------------------------------------------------
trees_filename <- "toy_example_1_1_1_1.trees"

testit::assert(file.exists(trees_filename))

phylogenies <- rBEAST::beast2out.read.trees(trees_filename)

# To get the densiTree function working, phylogenies must be of class multiphylo
class(phylogenies) <- "multiPhylo"

densiTree(
  phylogenies, 
  type = "cladogram", 
  alpha = 1/length(phylogenies), 
  consensus = NULL, 
  optim = FALSE, 
  scaleX = FALSE, 
  col = 1, 
  width = 1, 
  cex = 0.8
)

## ------------------------------------------------------------------------
plot_species_tree_with_outgroup(filename)
plot_species_tree_with_outgroup_nltt(filename, dt = dt)

## ------------------------------------------------------------------------
plot_posterior_samples(filename)

## ------------------------------------------------------------------------
true_gamma_statistics <- collect_species_tree_gammas(filename = filename)
knitr::kable(head(true_gamma_statistics))

## ------------------------------------------------------------------------
posterior_gamma_statistics <- collect_posterior_gammas(
  filename = filename
)
knitr::kable(head(posterior_gamma_statistics))

## ------------------------------------------------------------------------
true_nltt_values <- collect_species_tree_nltts(filename = filename, dt = dt)
knitr::kable(head(true_nltt_values))

## ------------------------------------------------------------------------
posterior_nltt_values <- collect_posterior_nltt_values(
  filename = filename, dt = dt
)
knitr::kable(head(posterior_nltt_values))

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = posterior_nltt_values,
  ggplot2::aes(t, nltt),
  main = "nLTT plots"
) + ggplot2::geom_point(
  color = "transparent"
) + ggplot2::scale_x_continuous(
  limits = c(0, 1)
) + ggplot2::scale_y_continuous(
  limits = c(0, 1)
) + ggplot2::stat_summary(
  fun.data = "mean_cl_boot", size = 0.5, lty = "dashed",
  color = I("black"), geom = "smooth"
) + ggplot2::geom_step(
  data = true_nltt_values,
  ggplot2::aes(t, nltt)
)

>>>>>>> d2334c4352d2381a8894f1825adf4546c5630efc
