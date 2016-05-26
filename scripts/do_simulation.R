if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a parameter filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}

source("~/GitHubs/R/Peregrine/read_file.R")
print(t(read_file(filename)$parameters[2,]))
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
print("Adding PBD output")
add_pbd_output(filename)
source("~/GitHubs/R/Peregrine/add_species_trees.R")
print("Adding species trees with outgroup")
add_species_trees(filename, add_outgroup = TRUE)
source("~/GitHubs/R/Peregrine/add_alignments.R")
print("Adding alignment(s)")
add_alignments(filename)
source("~/GitHubs/R/Peregrine/add_posteriors.R")
print("Creating BEAST2 posteriors")
add_posteriors(filename)
