## ------------------------------------------------------------------------
species_tree_id <- c(2, 2, 2, 2)
alignment_id <- c(3, 3, 3, 3)
beast_run <- c(4, 4, 4, 4)
id <- c(1, 2, 3, 4)
gamma <- c(-0.3, 0.5, -0.2, 0.1)

d1 <- data.frame(species_tree_id, alignment_id,
  beast_run, stringsAsFactors = FALSE)

d2 <- data.frame(id, gamma, stringsAsFactors = FALSE)

d <- c(d1, d2)
as.data.frame(d)


