#' Add BEAST2 posteriors to a file
#' @param filename Parameter filename
#' @param skip_if_output_present skip if output files are present, else remove these and start a new BEAST2 run
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return the number of posteriors added. Also modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_posteriors <- function(
  filename,
  skip_if_output_present = FALSE,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "add_posteriors: verbose should be TRUE or FALSE"
    )
  }
  if (skip_if_output_present != TRUE && skip_if_output_present != FALSE) {
    stop(
      "add_posteriors: skip_if_output_present should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename)) {
    stop("add_posteriors: invalid filename")
  }
  file <- Cer2016::read_file(filename)
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])

  n_posteriors_added <- 0

  if (!isTRUE(has_alignments(file))) {
    stop("add_posteriors: alignments absent")
  }

  for (sti in 1:2) {
    for (j in seq(1, n_alignments)) {
      alignment_index <- 1 + (sti - 1) + ((j - 1) * 2)
      alignment <- get_alignment_by_index(
        file = file,
        alignment_index = alignment_index
      )
      testit::assert(Cer2016::is_alignment(alignment))
      for (k in seq(1, n_beast_runs)) {
        posterior_index <- 1 + (k - 1) +
          ((j - 1) * n_alignments) +                                            # nolint
          ((sti - 1) * n_alignments * 2)
        posterior <- NA
        tryCatch(
          posterior <- get_posterior_by_index(
            file = file,
            posterior_index = posterior_index
          ),
          error = function(msg) {
            if (verbose) {
              print(msg) # Is not allowed to be 'message'
              cat(paste0(msg, "\n"), file = "add_posteriors.log")
            }
          }
        )
        if (is_beast_posterior(posterior)) {
          if (verbose) {
            message(
              "add_posteriors: posterior already present at posterior index ",
              posterior_index
            )
          }
          next
        }
        new_seed <- rng_seed + k
        if (verbose) {
          message("add_posteriors: setting seed to ", new_seed)
        }
        set.seed(new_seed)
        basefilename <- paste0(
          tools::file_path_sans_ext(filename), "_",
          sti, "_", j, "_", k
        )
        posterior <- alignment_to_beast_posterior(
          alignment_dnabin = alignment,
          base_filename = basefilename,
          mcmc_chainlength = mcmc_chainlength,
          rng_seed = new_seed,
          skip_if_output_present = skip_if_output_present,
          verbose = verbose
        )
        testit::assert(Cer2016::is_beast_posterior(posterior))

        if (verbose) {
          message(
            "add_posteriors: sorted posterior at posterior index ",
            posterior_index
          )
        }
        file <- set_posterior_by_index(
          file = file,
          posterior_index = posterior_index,
          posterior = posterior
        )
        testit::assert(
          are_identical_posteriors(
            get_posterior_by_index(file = file,
              posterior_index = posterior_index
            ),
            posterior
          )
        )
        n_posteriors_added <- n_posteriors_added + 1
      }
    }
  }
  saveRDS(file, file = filename)
  if (verbose) {
    message("file ", filename, " has gotten its posteriors")
  }
  n_posteriors_added
}
