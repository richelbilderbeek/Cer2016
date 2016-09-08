#' Tests if the nLTT statistics are of the same distribution
#' @param df data frame
#' @return data frame,
#' @export
posteriors_same_distr <- function(df) {
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
    df <- df %>% tidyr::spread(pi, nltt_stat)
    # Rename columns with numbers
    df <- plyr::rename(df, c("1" = "A", "2" = "B"))
    # Remove the si column
    df <- subset(df, select = -c(si))

    df <- df %>%
      dplyr::group_by(filename, sti, ai) %>%
      dplyr::summarise(
        same_distr = are_from_same_distribution(A, B)
      )
    return (df)
  }
  stop("Invalid data frame")
}
