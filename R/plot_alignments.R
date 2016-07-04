#' Plot alignments
#' @param filename name of the parameter file
#' @export
#' @author Richel Bilderbeek
plot_alignments <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_alignments: invalid filename")
  }
  base_filename <- tools::file_path_sans_ext(basename(filename))

  file <- Cer2016::read_file(filename)

  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  for (sti in 1:2) {
    for (ai in 1:n_alignments) {
      i <- a2i(sti = sti, ai = ai, nstpist = 2, napst = n_alignments)
      graphics::image(
        get_alignment_by_index(
          file = file,
          i = i
        ),
        main = paste(base_filename, "alignment ", ai, "of species tree ", sti)
      )
    }
  }
}
