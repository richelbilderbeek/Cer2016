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
  if (!all(has_alignments(file) == TRUE)) {
    stop("add_posteriors: alignments absent")
  }

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])

  n_posteriors_added <- 0

  for (sti in 1:2) {
    for (ai in 1:n_alignments) {
      alignment <- get_alignment(
        file = file,
        sti = sti,
        ai = ai
      )
      testit::assert(Cer2016::is_alignment(alignment))
      for (pi in 1:n_beast_runs) {
        posterior <- NA
        testit::assert(!is_posterior(posterior))
        tryCatch(
          posterior <- get_posterior(
            file = file,
            sti = sti,
            ai = ai,
            pi = pi
          ),
          error = function(msg) {
            if (verbose) {
              print(msg) # Is not allowed to be 'message'
              cat(paste0(msg, "\n"), file = "add_posteriors.log")
            }
          }
        )
        if (is_posterior(posterior)) {
          next
        }
        i <- 1 + (pi - 1) +
          ((ai - 1) * n_alignments) +                                            # nolint
          ((sti - 1) * n_alignments * 2)
        new_seed <- rng_seed + i
        set.seed(new_seed)
        basefilename <- paste0(
          tools::file_path_sans_ext(filename), "_",
          sti, "_", ai, "_", pi
        )
        posterior <- alignment_to_beast_posterior(
          alignment_dnabin = alignment,
          base_filename = basefilename,
          mcmc_chainlength = mcmc_chainlength,
          rng_seed = new_seed,
          skip_if_output_present = skip_if_output_present,
          verbose = verbose
        )
        testit::assert(Cer2016::is_posterior(posterior))

        file <- set_posterior(
          file = file, sti = sti, ai = ai, pi = pi,
          posterior = posterior
        )
        saveRDS(object = file, file = filename)
        testit::assert(
          are_identical_posteriors(
            get_posterior(file = file,
              sti = sti, ai = ai, pi = pi
            ),
            posterior
          )
        )
        n_posteriors_added <- n_posteriors_added + 1
      }
    }
  }
  n_posteriors_added
}
