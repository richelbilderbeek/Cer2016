## ------------------------------------------------------------------------
library(ape)
library(Cer2016)
library(ggplot2)
library(nLTT)
library(ribir)

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
plot_species_tree_with_outgroup(filename)
plot_species_tree_with_outgroup_nltt(filename)

## ------------------------------------------------------------------------
plot_posterior_samples(filename)

## ------------------------------------------------------------------------
plot_posterior_sample_nltts(filename)

## ------------------------------------------------------------------------
plot_posterior_nltts(filename)

