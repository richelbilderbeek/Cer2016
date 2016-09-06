library(Cer2016)
library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_nltt_stats.Rmd", output_file = "~/analyse_nltt_stats.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_nltt_stats.html -o analyse_nltt_stats.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
