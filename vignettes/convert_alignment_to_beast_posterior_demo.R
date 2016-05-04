## ------------------------------------------------------------------------
library(Cer2016)
library(nLTT)
library(phangorn)
library(rBEAST)
library(testit)

## ------------------------------------------------------------------------
#find_beast_bin_path()
find_beast_jar_path()

## ------------------------------------------------------------------------
n_taxa <- 5
phylogeny <- ape::rcoal(n = n_taxa)
plot(phylogeny)

## ------------------------------------------------------------------------
alignment <- convert_phylogeny_to_alignment(
  phylogeny = phylogeny,
  sequence_length = 10
)
image(alignment)

## ------------------------------------------------------------------------
base_filename <- "convert_alignment_to_beast_posterior_test"

if (file.exists(paste(base_filename, ".log", sep = ""))) {
  file.remove(paste(base_filename, ".log", sep = ""))  
}
if (file.exists(paste(base_filename, ".trees", sep = ""))) {
  file.remove(paste(base_filename, ".trees", sep = ""))  
}
if (file.exists(paste(base_filename, ".xml.state", sep = ""))) {
  file.remove(paste(base_filename, ".xml.state", sep = ""))  
}
posterior <- convert_alignment_to_beast_posterior(
  alignment,
  mcmc_chainlength = 10000,
  base_filename = base_filename,
  rng_seed = 42,
  beast_bin_path = "",
  beast_jar_path = find_beast_jar_path()
)

## ------------------------------------------------------------------------
last_tree <- tail(posterior, n = 1)[[1]]
plot(last_tree, main = "Last tree in posterior")

all_nltt_stats <- NULL
for (tree in posterior)
{
  all_nltt_stats = c(all_nltt_stats, nLTT::nLTTstat(phylogeny, tree))
}

hist(all_nltt_stats)

## ------------------------------------------------------------------------
if (file.exists(paste(base_filename, ".log", sep = ""))) {
  file.remove(paste(base_filename, ".log", sep = ""))  
}
if (file.exists(paste(base_filename, ".trees", sep = ""))) {
  file.remove(paste(base_filename, ".trees", sep = ""))  
}
if (file.exists(paste(base_filename, ".xml.state", sep = ""))) {
  file.remove(paste(base_filename, ".xml.state", sep = ""))  
}

