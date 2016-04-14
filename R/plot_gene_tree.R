plot_gene_tree <- function(filename) {
  assert(is_valid_file(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  png(paste(base_filename,"_gene_tree.png",sep=""))
  plot(file$pbd_output[[1]], main = paste(base_filename," gene tree",sep=""))
  dev.off()
}