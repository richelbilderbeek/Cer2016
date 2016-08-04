#' Collects the NRBS values between species trees and
#' posteriors in a parameter file in the melted/uncast/long form
#'
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of NRBS values between each species tree and their posteriors
#' @examples
#'   filename <- find_path("toy_example_3.RDa")
#'   df <- collect_file_nrbss(filename)
#'   testit::assert(names(df) == c("species_tree", "alignment", "beast_run", "state", "nrbs"))
#'   testit::assert(nrow(df) == 80)
#' @export
collect_file_nrbss <- function(
  filename,
  verbose = FALSE
) {
  if (length(filename) != 1) {
    stop(
      "collect_file_nrbss: ",
      "there must be exactly one filename supplied"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_file_nrbss: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_file_nrbss: ",
      "invalid file '", filename, "'"
    )
  }

  file <- Cer2016::read_file(filename)

  n_species_trees <- 2
  n_alignments <- as.numeric(
    file$parameters$n_alignments[2]
  )
  n_beast_runs <- as.numeric(
    file$parameters$n_beast_runs[2]
  )
  n_states <- as.numeric(
    as.numeric(file$parameters$mcmc_chainlength[2]) / 1000
  )
  n_rows <- n_species_trees * n_alignments * n_beast_runs * n_states

  # Create an empty data frame like this:
  # S A B T N    <- S: species tree index
  # 1 1 1 1 NA      A: alignment index
  # 1 1 1 2 NA      B: BEAST2 run index
  # 1 1 2 1 NA      T: MCMC sTate index
  # 1 1 2 2 NA      N: NRBS value
  # 1 2 1 1 NA
  # 1 2 1 2 NA
  # 1 2 2 1 NA
  # 1 2 2 2 NA
  # 2 1 1 1 NA
  # 2 1 1 2 NA
  # 2 1 2 1 NA
  # 2 1 2 2 NA
  # 2 2 1 1 NA
  # 2 2 1 2 NA
  # 2 2 2 1 NA
  # 2 2 2 2 NA
  df <- data.frame(
    species_tree = rep(seq(1, n_species_trees), each = n_alignments * n_beast_runs * n_states), # nolint
    alignment = rep(seq(1, n_alignments), each = n_states * n_beast_runs, times = n_species_trees), # nolint
    beast_run = rep(seq(1, n_beast_runs), each = n_states, times = n_species_trees * n_alignments), # nolint
    state = rep(seq(1, n_states), n_species_trees * n_beast_runs * n_alignments), # nolint
    nrbs = rep(NA, n_rows),
    stringsAsFactors = FALSE
  )

  for (i in 1:n_rows) {

    sti <- df$species_tree[i] # species tree index
    ai <- df$alignment[i] # alignment index
    pi <- df$beast_run[i] # posterior index
    si <- df$state[i] # state index
    # st: species tree
    st <- Cer2016::get_species_tree_by_index(file = file, sti = sti)
    testit::assert(class(st) == "phylo")
    testit::assert(si >= 1)
    testit::assert(si <= length(get_posterior(file, sti = sti, ai = ai, pi = pi)$trees)) # nolint
    # pt: posterior state tree, of type phylo
    pt <- Cer2016::get_posterior(file, sti = sti, ai = ai, pi = pi)$trees[[si]]
    testit::assert(class(pt) == "phylo")
    testit::assert(length(st$tip.label) == length(pt$tip.label))
    testit::assert(all.equal(sort(st$tip.label), sort(pt$tip.label)))
    df$nrbs[i] <- NA
    tryCatch(
      df$nrbs[i] <- nrbs(st, pt),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
  }

  df
}
