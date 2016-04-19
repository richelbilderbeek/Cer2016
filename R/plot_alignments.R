#' Plot alignments
#' @param filename name of the parameter file
#' @export
#' @author Richel Bilderbeek
plot_alignments <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_alignments: invalid filename")
  }
  base_filename <- tools::file_path_sans_ext(basename(filename))

  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  for (i in seq(1,n_species_trees_samples)) {
    for (j in seq(1,n_alignments)) {
      alignment_index <- 1 + j - 1 + ((i - 1) * n_species_trees_samples)        # nolint
      testit::assert(alignment_index >= 1)
      testit::assert(alignment_index <= length(file$alignments))
      image(file$alignments[[alignment_index]][[1]],
        main = paste(base_filename,"alignment",i,j)
      )
    }
  }
}