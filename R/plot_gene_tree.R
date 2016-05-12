#' Plot the extant inicipient species tree
plot_extant_incipient_tree <- function(filename) {
  testit::assert(is_valid_file(filename))
  base_filename <- basename(filename)
  file <- read_file(filename)
  graphics::plot(file$pbd_output[[1]], main = paste(
    base_filename, " gene tree", sep = "")
  )
}
