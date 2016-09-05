library(Cer2016)

print(has_beast2())
testit::assert(has_beast2())

# Copied from test-alignment_to_beast_posterior.R

base_filename <- file.path(getwd(), "test_beast2")
beast_log_filename <- paste0(base_filename, ".log")
beast_trees_filename <- paste0(base_filename, ".trees")
beast_state_filename <- paste0(base_filename, ".xml.state")

# Pre cleaning up
if (file.exists(beast_log_filename)) {
  file.remove(beast_log_filename)
}
if (file.exists(beast_trees_filename)) {
  file.remove(beast_trees_filename)
}
if (file.exists(beast_state_filename)) {
  file.remove(beast_state_filename)
}

alignment <- convert_phylogeny_to_alignment(
  phylogeny = ape::rcoal(5),
  sequence_length = 10,
  mutation_rate = 1
)

beast_jar_path <- find_beast_jar_path()
testit::assert(file.exists(beast_jar_path))

posterior <- alignment_to_beast_posterior(
  alignment_dnabin = alignment,
  nspp = 10,
  base_filename = base_filename,
  rng_seed = 42,
  beast_jar_path = beast_jar_path,
  skip_if_output_present = FALSE,
  verbose = FALSE
)

print(posterior)

warnings()
