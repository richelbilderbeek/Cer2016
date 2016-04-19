## ------------------------------------------------------------------------
library(ape)
library(Cer2016)
n_taxa <- 5
phylogeny <- rcoal(n = n_taxa)
alignment <- convert_phylogeny_to_alignment(
  phylogeny = phylogeny,
  sequence_length = 10
)
image(alignment)

