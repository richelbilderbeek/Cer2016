#' #' Analyse a single file
#' #' @param filename Parameter filename
#' #' @return Nothing?
#' #' @export
#' #' @author Richel Bilderbeek
#' analyse_single <- function(filename) {
#'   if (!file.exists(filename)) {
#'     print(paste(filename,": not found"))
#'     stop()
#'   }
#'   plot_gene_tree(filename)
#'   plot_species_tree_with_outgroup(filename)
#'   plot_species_tree_with_outgroup_nltt(filename)
#'   plot_alignments(filename)
#'   plot_posterior_average_nltts(filename)
#'   plot_posterior_samples(filename)
#'   plot_posterior_sample_nltts(filename)
#'   plot_posterior_nltt_stats_histogram(filename)
#' }