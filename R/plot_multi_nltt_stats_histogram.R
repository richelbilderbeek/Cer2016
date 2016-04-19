plot_multi_nltt_stats_histogram <- function(filenames) {

  data <- data.frame()

  for (filename in filenames) {
    testit::assert(is_valid_file(filename))
    file <- load_parameters_from_file(filename)
    n_species_trees_samples <- as.numeric(
      file$parameters$n_species_trees_samples[2]
    )
    n_alignments <- as.numeric(file$parameters$n_alignments[2])
    n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
    for (i in seq(1,n_species_trees_samples)) {
      for (j in seq(1,n_alignments)) {
        for (k in seq(1,n_beast_runs)) {
          base_filename <- basename(filename)
          trees_filename <- paste(
            base_filename,"_",i,"_",j,"_",k,".trees",
            sep = ""
          )
          all_trees <- rBEAST::beast2out.read.trees(trees_filename)
          all_nltt_stats <- NULL
          for (tree in all_trees) {
            all_nltt_stats <- c(
              all_nltt_stats,
              nLTT::nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree)
            )
          }
          this_data <- data.frame(length = all_nltt_stats)
          this_data$description <- basename(filename)
          data <- rbind(data,this_data)
        }
      }
    }
  }

  myplot <- ggplot2::ggplot(
    data, ggplot2::aes(length, fill = description)
  ) + ggplot2::geom_histogram(
    alpha = 0.25,
    ggplot2::aes(y = ..density..),
    position = 'identity',
    binwidth = 0.005
  ) + ggplot2::ggtitle("nLTT statistics distribution") +
    ggplot2::theme(
      plot.title = ggplot2::element_text(lineheight = 0.8, face = "bold")
    ) +
    ggplot2::scale_fill_manual(" ", values = c("red","blue"))
  ggplot2::grid.arrange(myplot)
  ggplot2::ggsave("multi_nltt_stats_histogram.png")
}