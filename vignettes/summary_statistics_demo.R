## ------------------------------------------------------------------------
library(ape)
phylogeny <- rcoal(10)
plot(phylogeny)

## ------------------------------------------------------------------------
measurement_1 <- runif(n = 1, max = sum(phylogeny$edge.length))
measurement_2 <- runif(n = 1, max = sum(phylogeny$edge.length))
print(measurement_1)
print(measurement_2)

