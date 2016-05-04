## ------------------------------------------------------------------------
library(ape)
library(ggplot2)
library(ribir)
set.seed(42)

# Create some random phylogenies
phylogeny1 <- rcoal(10)
phylogeny2 <- rcoal(20)
phylogeny3 <- rcoal(30)
phylogeny4 <- rcoal(40)
phylogeny5 <- rcoal(50)
phylogeny6 <- rcoal(60)
phylogeny7 <- rcoal(70)
phylogenies <- c(phylogeny1, phylogeny2, phylogeny3,
  phylogeny4, phylogeny5, phylogeny6, phylogeny7
)

# Obtain the nLTT values
dt <- 0.1
nltt_values <- get_nltt_values(phylogenies, dt = dt)

## ------------------------------------------------------------------------
#Plot the phylognies, where the individual nLTT values are visible
qplot(t, nltt, data = nltt_values, geom = "point",
  ylim = c(0,1),
  main = "Average nLTT plot of phylogenies", color = id, size = I(0.1)
) + stat_summary(
  fun.data = "mean_cl_boot", color = "red", geom = "smooth"
)

## ------------------------------------------------------------------------
# Plot the phylognies, where the individual nLTT values are omitted
qplot(
  t, nltt, data = nltt_values, geom = "blank", ylim = c(0,1),
  main = "Average nLTT plot of phylogenies"
) + stat_summary(
  fun.data = "mean_cl_boot", color = "red", geom = "smooth"
)

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = nltt_values,
  aes(t, nltt),
  main = "Average nLTT plot of phylogenies"
) + geom_point(color = "transparent") +
  scale_x_continuous(limits = c(0, 1)) +
  scale_y_continuous(limits = c(0, 1)) +
ggplot2::stat_summary(
  fun.data = "mean_cl_boot", color = "red", geom = "smooth"
)

## ------------------------------------------------------------------------
true_phylogeny <- rcoal(10)
true_nltt_values <- get_nltt_values(list(true_phylogeny), dt = dt)

## ------------------------------------------------------------------------
plot(true_phylogeny)

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = nltt_values,
  aes(t, nltt),
  main = "nLTT plots"
) + geom_step(
  data = true_nltt_values,
  aes(t, nltt)
) + geom_point(
  color = "transparent"
) + scale_x_continuous(
  limits = c(0, 1)
) + scale_y_continuous(
  limits = c(0, 1)
) + stat_summary(
  fun.data = "mean_cl_boot", size = 0.5, lty = "dashed", 
  color = I("black"), geom = "smooth"
) + geom_step(
  data = true_nltt_values,
  aes(t, nltt)
) 

