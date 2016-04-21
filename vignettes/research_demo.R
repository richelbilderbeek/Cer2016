## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
df <- check_progress()
knitr::kable(df)

## ------------------------------------------------------------------------
filenames = c(
  "toy_example_1.RDa", 
  "toy_example_2.RDa", 
  "toy_example_3.RDa", 
  "toy_example_4.RDa"
)

## ------------------------------------------------------------------------
for (filename in filenames) {
  if (file.exists(filename)) {
    file.remove(filename)
  }
}

## ------------------------------------------------------------------------
rng_seeds <- rep(x = 1, times = 4)
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
    mutation_rate = mutation_rates[i],
    n_alignments = n_alignmentses[i],
    sequence_length = sequence_lengths[i],
    mcmc_chainlength = mcmc_chainlengths[i],
    n_beast_runs = n_beast_runses[i],
    filename = filenames[i]
  )  
}

## ------------------------------------------------------------------------
df <- check_progress()
knitr::kable(df)

## ------------------------------------------------------------------------
for (filename in filenames) {
  add_pbd_output(filename)  
}

## ------------------------------------------------------------------------
cols <- setNames(c("gray","black"),c("i","g"))

for (filename in filenames) {
  testit::assert(is_valid_file(filename))
  print(filename)
  testit::assert(length(read_file(filename)$pbd_output$igtree.extant$tip.label) > 0)
  phytools::plotSimmap(
    read_file(filename)$pbd_output$igtree.extant, 
    colors = cols
  )
}

## ------------------------------------------------------------------------
df <- check_progress()
knitr::kable(df)

