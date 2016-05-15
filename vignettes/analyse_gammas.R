## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_gamma_statistics(phylogenies)
knitr::kable(df)

