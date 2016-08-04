#' Calculates the nLTT statistics from multiple files
#' @param filenames the names of the files
#' @return a distribution of nLTT statistics
#' @export
#' @examples
#'   nltt_stats <- calc_nltt_stats_from_files(
#'     filenames = c(
#'       find_path("toy_example_1.RDa"),
#'       find_path("toy_example_2.RDa")
#'     )
#'   )
#'   expected_names <- c("filename", "sti", "ai", "pi", "si", "nltt_stat")
#'   testit::assert(names(nltt_stats) == expected_names)
#' @author Richel Bilderbeek
calc_nltt_stats_from_files <- function(filenames) {

  # Check all files
  for (filename in filenames) {
    if (!Cer2016::is_valid_file(filename)) {
      stop("calc_nltt_stats_from_files: invalid file '",
        filename, "'"
      )
    }
  }

  # Calculate the number of rows needed
  n_rows <- 0
  for (filename in filenames) {
    file <- Cer2016::read_file(filename)
    nst <- 2 # Number of species trees
    napst <- Cer2016::extract_napst(file) # number of alignments per species tree # nolint
    nppa <- Cer2016::extract_nppa(file) # number of number of posteriors per alignment # nolint
    nspp <- Cer2016::extract_nspp(file) # number of states per posterior
    n_rows_for_this_file <- nst * napst * nppa * nspp
    n_rows <- n_rows + n_rows_for_this_file
  }
  df <- data.frame(
    filename = rep(NA, n_rows),
    sti = rep(NA, n_rows),
    ai = rep(NA, n_rows),
    pi = rep(NA, n_rows),
    si = rep(NA, n_rows),
    nltt_stat = rep(NA, n_rows)
  )

  # Merging, a bit like this example code:
  # sub1 <- data.frame(y = c(1,2), z = c(3,4))                                     # nolint
  # sub2 <- data.frame(y = c(5,6), z = c(7,8))                                     # nolint
  # super <- data.frame(x = rep(c(1,2), each = 2), y = rep(NA, 4), z = rep(NA, 4)) # nolint
  # super[1:2, c("y", "z")] <- sub1                                                # nolint
  # super[3:4, c("y", "z")] <- sub2                                                # nolint
  index <- 1
  for (filename in filenames) {
    nltt_stats <- Cer2016::calc_nltt_stats_from_file(
      filename = filename
    )
    df[
      index:(index + nrow(nltt_stats) - 1),
      c("sti", "ai", "pi", "si", "nltt_stat")
    ] <- nltt_stats
    df$filename[index:(index + nrow(nltt_stats) - 1)] <- rep(
      basename(filename), nrow(nltt_stats)
    )
    index <- index + nrow(nltt_stats)
  }
  testit::assert(
    c("filename", "sti", "ai", "pi", "si", "nltt_stat")
      == names(df)
  )

  # Make factors
  df$filename <- as.factor(df$filename)
  df$sti <- as.factor(df$sti)
  df$ai <- as.factor(df$ai)
  df$pi <- as.factor(df$pi)
  df$si <- as.factor(df$si)

  df

}
