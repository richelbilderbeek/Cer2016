library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_esses.Rmd", output_file =  "~/analyse_esses.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_esses.html -o analyse_esses.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
