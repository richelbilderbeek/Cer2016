library(Cer2016)
library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_time.Rmd", output_file = "~/analyse_time.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_time.html -o analyse_time.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
