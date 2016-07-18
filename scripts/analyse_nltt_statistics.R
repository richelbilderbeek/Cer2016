library(Cer2016)
library(rmarkdown)

tryCatch(
  rmarkdown::render("analyse_nltt_statistics.Rmd", output_file = "~/analyse_nltt_statistics.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_nltt_statistics.html -o analyse_nltt_statistics.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
