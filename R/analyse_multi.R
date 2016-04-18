#' Analyse multiple files
#' @param filenames Parameter filenames
#' @return Nothing?
#' @export
#' @author Richel Bilderbeek
analyse_multi <- function(filenames) {
  plot_multi_average_nltts(filenames)
  plot_multi_nltt_stats_histogram(filenames)
}