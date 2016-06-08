#' Plot the extant inicipient species tree
#' @param filename name of the parameter file
#' @return Nothing. It does produce a plot
#' @export
#' @author Richel Bilderbeek
plot_extant_incipient_tree <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_extant_incipient_tree: ",
      "file '", filename, "' is invalid"
    )
  }
#   base_filename <- basename(filename)
#   file <- Cer2016::read_file(filename)
#   graphics::plot(file$pbd_output$igtree.extant, main = paste(
#     base_filename, " gene tree", sep = "")
#   )

  colors <- setNames(c("gray","black"), c("i","g"))
  testit::assert(length(read_file(filename)$pbd_output$igtree.extant$tip.label) > 0)
  phytools::plotSimmap(
    read_file(filename)$pbd_output$igtree.extant,
    colors = colors
  )

}
