# This function caused a cyclic namespace dependency, as shown by Travis at
# https://travis-ci.org/richelbilderbeek/Cer2016/builds/127551462#L5457
#
# ** R
# ** inst
# ** preparing package for lazy loading
# Error in loadNamespace(package, c(which.lib.loc, lib.loc)) :
#   cyclic namespace dependency detected when loading ‘Cer2016’, already loading ‘Cer2016’
# Error : package or namespace load failed for ‘Cer2016’
# Error : unable to load R code in package ‘Cer2016’
# ERROR: lazy loading failed for package ‘Cer2016’
# * removing ‘/home/travis/build/richelbilderbeek/Cer2016/..Rcheck/Cer2016’
#
# Solution: make it a function

sandboxy_trash <- function() {
  library(Cer2016)
  library(ape)

  filenames <- c(
    "toy_example_1.RDa",
    "toy_example_2.RDa",
    "toy_example_3.RDa",
    "toy_example_4.RDa"
  )

  rng_seeds <- seq(1, 4)
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

  for (filename in filenames) {
    add_pbd_output(filename)
  }

  for (filename in filenames) {
    files  <- c()
    file   <- read_file(filename)
  }

  for (filename in files) {
    print(names(filename))
  }
  names(file$pbd_output$tree)
  #gotcha!
}