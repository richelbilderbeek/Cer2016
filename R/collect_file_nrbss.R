#' Collects the NRBS values between species trees and
#' posteriors in a parameter file in the melted/uncast/long form
#'
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of NRBS values between each species tree and their posteriors
#' @examples
#'   filename <- find_path("toy_example_3.RDa")
#'   df <- collect_file_nrbss(filename)
#'   testit::assert(nrow(df) > 2)
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

  n_species_trees <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_beast_runs <- as.numeric(
    file$parameters$n_beast_runs[2]
  )
  n_states <- as.numeric(
    as.numeric(file$parameters$mcmc_chainlength[2]) / 1000
  )
  n_rows <- n_species_trees * n_beast_runs * n_states

  # Create an empty data frame like this:
  # S B T N    <- S: species tree index
  # 1 1 1 NA      B: BEAST2 run index
  # 1 1 2 NA      T: MCMC sTate index
  # 1 1 3 NA      N: NRBS value
  # 1 2 1 NA
  # 1 2 2 NA
  # 1 2 3 NA
  # 2 1 1 NA
  # 2 1 2 NA
  # 2 1 3 NA
  # 2 2 1 NA
  # 2 2 2 NA
  # 2 2 3 NA
  df <- data.frame(
    species_tree = rep(seq(1, n_species_trees), each = n_beast_runs * n_states),
    beast_run = rep(seq(1, n_beast_runs), each = n_states, times = n_species_trees),
    state = rep(seq(1, n_states), n_species_trees * n_beast_runs),
    nrbs = rep(NA, n_rows),
    stringsAsFactors = FALSE
  )

  # st: species tree, of type phylo
  # sti: species tree index, of type int
  # pti: posterior tree index, of type int
  # si: MCMC state index, of type int
  # st: MCMC state tree, of type phylo
  index <- 1
  for (i in seq(1, n_rows)) {

    species_tree_index <- df$species_tree[i]
    beast_run_index <- df$beast_run[i]
    state_index <- df$state[i]

    posterior_index <- ((beast_run_index - 1) * n_beast_runs) + beast_run_index

    st <- file$species_trees_with_outgroup[[species_tree_index]][[1]]
    testit::assert(posterior_index >= 1)
    testit::assert(posterior_index <= length(file$posterior))
    testit::assert(state_index >= 1)
    #testit::assert(state_index <= length(file$posterior[[posterior_index]]))
    pt <- file$posterior[[posterior_index]][[1]][[state_index]]
    testit::assert(class(st) == "phylo")
    testit::assert(class(pt) == "phylo")
    df$nrbs[i] <- nrbs(st, pt)
  }

  df
}
