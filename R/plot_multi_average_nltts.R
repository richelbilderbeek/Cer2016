plot_multi_average_nltts <- function(filenames) {
  png(paste("multi_average_nltts.png", sep = ""))

  for (h in c(1,length(filenames))) {
    filename <- filenames[h]
    testit::assert(is_valid_file(filename))
    file <- read_file(filename)

    n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
    n_alignments <- as.numeric(file$parameters$n_alignments[2])
    n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
    for (i in seq(1,n_species_trees_samples)) {
      for (j in seq(1,n_alignments)) {
        for (k in seq(1,n_beast_runs)) {
          base_filename <- basename(filename)
          trees_filename <- paste(
            base_filename, "_", i, "_", j,"_", k, ".trees", sep = ""
          )
          testit::assert(file.exists(trees_filename))
          # all_trees <- beast2out.read.trees(trees_filename)
          # linetype <- ifelse(h == 1, 1, 3)
          # if (h == 1 && i == 1 && j == 1 && k == 1)  {
          #   get_average_nltt(all_trees,replot = FALSE,lty=1,lwd = 2, main="Average nLTTs")
          # } else {
          #   get_average_nltt(all_trees,replot = TRUE, lty = linetype,lwd = 2)
          # }
        }
      }
    }
  }
  legend(0.7,0.3, # Top left
    c('BD', 'PBD'), # puts text in the legend
    lty = c(1, 3), # gives the legend appropriate symbols (lines)
    lwd = c(2, 2)
  )
  dev.off()
}