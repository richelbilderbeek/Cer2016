#' Plot
plot_species_tree_repeatabilities <- function() {
  # How well do the BEAST2 runs on the multiple species trees match?

  # Filenames have the form:
  # * 'article_a_b_c_d_e_f_g.trees'
  # * 'example_i_e_f_g.trees'
  # a: 0-base index of birth rate
  # b: 0-base index of lambda
  # c: 0-base index of mu
  # d: 0-base index of mutation rate
  # e: 0-base index of alignment length
  # f: 1-base index of species tree sampled from gene tree
  # g: 1-base index of alignment simulated from species tree
  # h: 1-base index of BEAST2 run on an alignment
  # i: 1-base index of the example
  for (trees_filename in list.files(path = ".",
    pattern = "^(toy_example|example|article)_.*_1_1_1\\.trees")
  ) {
    trees_filename_1 <- trees_filename
    trees_filename_2 <- gsub("_1_1_1.trees","_1_1_2.trees", trees_filename)
    trees_filename_3 <- gsub("_1_1_1.trees","_1_2_1.trees", trees_filename)
    trees_filename_4 <- gsub("_1_1_1.trees","_1_2_2.trees", trees_filename)
    trees_filename_5 <- gsub("_1_1_1.trees","_2_1_1.trees", trees_filename)
    trees_filename_6 <- gsub("_1_1_1.trees","_2_1_2.trees", trees_filename)
    trees_filename_7 <- gsub("_1_1_1.trees","_2_2_1.trees", trees_filename)
    trees_filename_8 <- gsub("_1_1_1.trees","_2_2_2.trees", trees_filename)
    if (!file.exists(trees_filename_2)) next
    if (!file.exists(trees_filename_3)) next
    if (!file.exists(trees_filename_4)) next
    if (!file.exists(trees_filename_5)) next
    if (!file.exists(trees_filename_6)) next
    if (!file.exists(trees_filename_7)) next
    if (!file.exists(trees_filename_8)) next
    parameter_filename <- basename(trees_filename)
    parameter_filename <- substr(
      parameter_filename,1,nchar(parameter_filename) - 6
    )
    parameter_filename <- paste(parameter_filename, ".RDa", sep = "")

    png_filename <- basename(trees_filename)
    png_filename <- substr(png_filename,1,nchar(png_filename) - 6)
    png_filename <- paste(
      png_filename, "_species_tree_repeatability.png", sep = ""
    )

    print(paste(
      trees_filename_1, trees_filename_2,parameter_filename, png_filename)
    )
    testit::assert(is_valid_file(parameter_filename))
    parameter_file <- read_file(parameter_filename)
    testit::assert(file.exists(trees_filename))
    testit::assert(file.exists(trees_filename_1))
    testit::assert(file.exists(trees_filename_2))
    testit::assert(file.exists(trees_filename_3))
    testit::assert(file.exists(trees_filename_4))
    testit::assert(file.exists(trees_filename_5))
    testit::assert(file.exists(trees_filename_6))
    testit::assert(file.exists(trees_filename_7))
    testit::assert(file.exists(trees_filename_8))
    nLTT::nLTT.plot(
      phy = parameter_file$species_trees_with_outgroup[[1]][[1]],
      replot = TRUE,lty = 1, lwd = 1, main = "Repeatability alignments"
    )
    nLTT::nLTT.plot(
      phy = parameter_file$species_trees_with_outgroup[[2]][[1]],
      replot = FALSE,lty = 1,lwd = 1
    )
    species_trees <- c(
      rBEAST::beast2out.read.trees(trees_filename_1),
      rBEAST::beast2out.read.trees(trees_filename_2),
      rBEAST::beast2out.read.trees(trees_filename_3),
      rBEAST::beast2out.read.trees(trees_filename_4),
      rBEAST::beast2out.read.trees(trees_filename_5),
      rBEAST::beast2out.read.trees(trees_filename_6),
      rBEAST::beast2out.read.trees(trees_filename_7),
      rBEAST::beast2out.read.trees(trees_filename_8)
    )

    df <- ribir::get_nltt_values(species_trees, dt = 0.01)
    ggplot2::qplot(t, nltt, data = df, geom = "blank", ylim = c(0,1), main = "Average nLTT plot of phylogenies") +
      ggplot2::stat_summary(fun.data = "mean_cl_boot", color = "red", geom = "smooth")
  }
}
