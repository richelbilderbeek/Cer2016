## ------------------------------------------------------------------------
library(Cer2016)
library(nLTT)
library(phangorn)
library(testit)

## ------------------------------------------------------------------------
n_taxa <- 5
phylogeny <- rcoal(n = n_taxa)
plot(phylogeny)

## ------------------------------------------------------------------------
alignment <- convert_phylogeny_to_alignment(
  phylogeny = phylogeny,
  sequence_length = 10
)
image(alignment)

