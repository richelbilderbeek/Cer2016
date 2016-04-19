#' Plots the incipient species tree and species tree
#' @export
plot_gene_tree_versus_species_trees <- function() {

  for (parameter_filename in list.files(
    path = ".",
    pattern = "^(toy_example|example|article)_.*\\.RDa$")
  ) {
    #parameter_filename <- "article_0_1_2_1_0.RDa"
    print(parameter_filename)
    testit::assert(is_valid_file(parameter_filename))
    # base_filename <- basename(parameter_filename)
    png_filename <- basename(parameter_filename)
    png_filename <- substr(png_filename,1,nchar(png_filename) - 0)
    png_filename <- paste(
      png_filename,
      "_gene_tree_versus_species_trees.png",
      sep = ""
    )
    file <- read_file(parameter_filename)
    if (typeof(file$pbd_output) != "list") {
      print("SKIPPED")
      next
    }
    trees <- sample_species_trees_from_pbd_sim_output(n = 100, file$pbd_output)
    png(png_filename)
    nLTT::nLTT.plot(
      file$pbd_output$tree
    )
    # get_average_nltt(phylogenies = trees, plot_nltts = TRUE, replot = TRUE, col = "red", lty = 3)
    dev.off()
  }
}
