## ------------------------------------------------------------------------
library(ape)
library(Cer2016)

phylogeny <- ape::read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
plot(phylogeny)

## ------------------------------------------------------------------------
new_phylogeny_1 <- add_outgroup_to_phylogeny(phylogeny, stem_length = 0.0)
plot(new_phylogeny_1)

## ------------------------------------------------------------------------
n_taxa <- length(phylogeny$tip.label)
crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
new_phylogeny_2 <- add_outgroup_to_phylogeny(phylogeny, stem_length = crown_age)
plot(new_phylogeny_2)

## ------------------------------------------------------------------------
plot(phylogeny, main = "add_outgroup_to_phylogeny")
add.scale.bar(x = 0, y = 5)
plot(new_phylogeny_1)
add.scale.bar(x = 0, y = 6)
plot(new_phylogeny_2)
add.scale.bar(x = 0, y = 6)
par(mfrow = c(1, 1))

