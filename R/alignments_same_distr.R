#' Tests if the nLTT statistics between alignments
#' are of the same distribution
#' @param df data frame with column names 'filename',
#'   'sti' (Species Tree Index), 'ai' (Alignment Index), 'pi' (Posterior
#'  Index), 'si' (State Index) and 'nltt_stat' (the nLTT statistic between
#'  that posterior state its phylogeny and the sampled species tree)
#' @return data frame
#' @examples
#'   nltt_stats <- read_collected_nltt_stats()
#'   df <- alignments_same_distr_nltt_stat(nltt_stats)
#'   testit::assert(all(names(df) == c("filename", "sti", "same_distr")))
#' @export
alignments_same_distr_nltt_stat <- function(df) {
  filename <- NULL; rm(filename)
  sti <- NULL; rm(sti)
  ai <- NULL; rm(ai)
  pi <- NULL; rm(pi)
  si <- NULL; rm(si)
  nltt_stat <- NULL; rm(nltt_stat)
  A <- NULL; rm(A)
  B <- NULL; rm(B)

  `%>%` <- dplyr::`%>%`

  if ("filename" %in% names(df) &&
    "sti" %in% names(df) &&
    "ai" %in% names(df) &&
    "pi" %in% names(df) &&
    "si" %in% names(df) &&
    "nltt_stat" %in% names(df)
  ) {
    # Spread the posterior indices over multiple columns
    df <- df %>% tidyr::spread(ai, nltt_stat)
    # Rename columns with numbers
    df <- plyr::rename(df, c("1" = "A", "2" = "B"))
    # If there had been only one alignment index, there will be no column B
    if (!"B" %in% names(df)) {
      stop("Cannot compare alignments if there is only one")
    }
    # Remove the pi and si columns
    df <- subset(df, select = -c(pi, si))

    df <- df %>%
      dplyr::group_by(filename, sti) %>%
      dplyr::summarise(
        same_distr = are_from_same_distribution(A, B)
      )
    return (df)
  }
  stop("Invalid data frame")
}
