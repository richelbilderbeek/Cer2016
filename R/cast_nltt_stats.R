#' Of a dataframe, cast the multiple nltt_stat values per state index
#' to one row
#' @param df a dataframe
#' @return a data frame
#' @export
cast_nltt_stats <- function(df) {
  if ("filename" %in% names(df) &&
    "sti" %in% names(df) &&
    "ai" %in% names(df) &&
    "pi" %in% names(df) &&
    "si" %in% names(df) &&
    "nltt_stat" %in% names(df)
  ) {
    return (reshape2::dcast(
        df,
        filename + sti + ai + pi ~ si,
        value.var = "nltt_stat"
      )
    )
  }
  stop("Invalid data frame")
}
