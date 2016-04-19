#' #' How well do the BEAST2 runs on the multiple alignments match?
#' #' @export
#' #' @author Richel Bilderbeek
#' plot_alignment_repeatabilities <- function() {
#'
#'   # Filenames have the form:
#'   # * 'article_a_b_c_d_e_f_g.trees'
#'   # * 'example_i_e_f_g.trees'
#'   # a: 0-base index of birth rate
#'   # b: 0-base index of lambda
#'   # c: 0-base index of mu
#'   # d: 0-base index of mutation rate
#'   # e: 0-base index of alignment length
#'   # f: 1-base index of species tree sampled from gene tree
#'   # g: 1-base index of alignment simulated from species tree
#'   # h: 1-base index of BEAST2 run on an alignment
#'   # i: 1-base index of the example
#'   for (trees_filename in list.files(path = ".", pattern = "^(toy_example|example|article)_.*_1_1\\.trees")) {
#'     trees_filename_1 <- trees_filename
#'     trees_filename_2 <- gsub("_1_1.trees","_1_2.trees", trees_filename)
#'     trees_filename_3 <- gsub("_1_1.trees","_2_1.trees", trees_filename)
#'     trees_filename_4 <- gsub("_1_1.trees","_2_2.trees", trees_filename)
#'     if (!file.exists(trees_filename_2)) next
#'     if (!file.exists(trees_filename_3)) next
#'     if (!file.exists(trees_filename_4)) next
#'
#'     parameter_filename <- tools::file_path_sans_ext(basename(trees_filename))
#'     parameter_filename <- substr(parameter_filename,1,nchar(parameter_filename) - 6)
#'     parameter_filename <- paste(parameter_filename,".RDa",sep="")
#'
#'     png_filename <- tools::file_path_sans_ext(basename(trees_filename))
#'     png_filename <- substr(png_filename,1,nchar(png_filename) - 4)
#'     png_filename <- paste(png_filename,"_alignment_repeatability.png",sep="")
#'
#'     print(paste(trees_filename_1,trees_filename_2,parameter_filename, png_filename))
#'     testit::assert(is_valid_file(parameter_filename))
#'     parameter_file <- read_file(parameter_filename)
#'     testit::assert(file.exists(trees_filename))
#'     testit::assert(file.exists(trees_filename_1))
#'     testit::assert(file.exists(trees_filename_2))
#'     testit::assert(file.exists(trees_filename_3))
#'     testit::assert(file.exists(trees_filename_4))
#'     png(png_filename)
#'     nLTT::nLTT.plot(
#'       phy = parameter_file$species_trees_with_outgroup[[1]][[1]],
#'       replot = TRUE,
#'       lty = 1,
#'       lwd = 1,
#'       main = "Repeatability alignments"
#'     )
#'     df <- ribir::get_nltt_values(
#'       c(
#'         rBEAST::beast2out.read.trees(trees_filename_1),
#'         rBEAST::beast2out.read.trees(trees_filename_2),
#'         rBEAST::beast2out.read.trees(trees_filename_3),
#'         rBEAST::beast2out.read.trees(trees_filename_4)
#'       ),
#'       dt = 0.01
#'     )
#'     ggplot2::qplot(t, nltt, data = df, geom = "point", ylim = c(0,1),
#'       main = "Average nLTT plot of phylogenies", color = id,
#'       size = I(0.1)) + ggplot2::stat_summary(
#'         fun.data = "mean_cl_boot", color = "red", geom = "smooth")
#'
#'   }
#' }