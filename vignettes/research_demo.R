## ------------------------------------------------------------------------
library(Cer2016)
library(ape)

## ------------------------------------------------------------------------
filenames <- c(
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
scrs <- rep(1.0, times = 4)
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
    add_outgroup = TRUE,
    mutation_rate = mutation_rates[i],
    n_alignments = n_alignmentses[i],
    sequence_length = sequence_lengths[i],
    mcmc_chainlength = mcmc_chainlengths[i],
    n_beast_runs = n_beast_runses[i],
    filename = filenames[i]
  )  
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  add_pbd_output(filename)  
}

## ------------------------------------------------------------------------
colors <- setNames(c("gray","black"), c("i","g"))

for (filename in filenames) {
  testit::assert(is_valid_file(filename))
  testit::assert(length(read_file(filename)$pbd_output$igtree.extant$tip.label) > 0)
  print(filename)
  phytools::plotSimmap(
    read_file(filename)$pbd_output$igtree.extant, 
    colors = colors
  )
  nLTT::nLTT.plot(read_file(filename)$pbd_output$tree)
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  add_species_trees_with_outgroup(filename)  
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  print(filename)
  plot_species_tree_with_outgroup(filename)
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  add_alignments(filename)  
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  print(filename)
  plot_alignments(filename)
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  add_posteriors(
    filename, 
    skip_if_output_present = TRUE
  )
}

## ------------------------------------------------------------------------
for (filename in filenames) {
  print(filename)
  plot_posterior_samples(filename)
  plot_posterior_sample_nltts(filename)
}

## ------------------------------------------------------------------------
plot_posterior_nltts(filenames[1])
plot_posterior_nltts(filenames[2])

## ------------------------------------------------------------------------
plot_posterior_nltts(filenames[3])
plot_posterior_nltts(filenames[4])

