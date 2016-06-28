library(Cer2016)
library(knitr)
library(rmarkdown)

tryCatch(
  knitr::knit("../vignettes/troubleshooting.Rmd", "troubleshooting_knitr.pdf"),
  error = function(msg) { message(msg) }
)

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "~/GitHubs/Cer2016/scripts/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc troubleshooting_pandoc.html -o troubleshooting_pandoc.pdf"),
  error = function(msg) { message(msg) }
)
