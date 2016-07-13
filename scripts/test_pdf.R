library(Cer2016)
library(knitr)
library(rmarkdown)

# Info for issue #71
cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat("pandoc (before setting RSTUDIO_PANDOC)\n", file = "create_test_pdf_r.log", append = TRUE)
cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat(Sys.which("pandoc"), file = "create_test_pdf_r.log", append = TRUE)
cat("\n--------\n", file = "create_test_pdf_r.log", append = TRUE)
cat(system("pandoc -v"), file = "create_test_pdf_r.log", append = TRUE)

Sys.setenv(RSTUDIO_PANDOC="/usr/bin/pandoc") 

cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat("\npandoc (after setting RSTUDIO_PANDOC)\n", file = "create_test_pdf_r.log", append = TRUE)
cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat(Sys.which("pandoc"), file = "create_test_pdf_r.log", append = TRUE)
cat("\n--------\n", file = "create_test_pdf_r.log", append = TRUE)
cat(system("pandoc -v"), file = "create_test_pdf_r.log", append = TRUE)
cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat("\npdflatex\n", file = "create_test_pdf_r.log", append = TRUE)
cat("\n========\n", file = "create_test_pdf_r.log", append = TRUE)
cat(Sys.which("pdflatex"), file = "create_test_pdf_r.log", append = TRUE)
cat("\n--------\n", file = "create_test_pdf_r.log", append = TRUE)
cat(system("pdflatex -v"), file = "create_test_pdf_r.log", append = TRUE)
cat("\n--------\n", file = "create_test_pdf_r.log", append = TRUE)

# Pandoc with squiggle
tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "~/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/troubleshooting_pandoc.html -o test_pdf_pandoc_tilde.pdf"),
  error = function(msg) { message(msg) }
)

# Pandoc with full path

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "/home/p230198/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc /home/p230198/troubleshooting_pandoc.html -o test_pdf_pandoc_full.pdf"),
  error = function(msg) { message(msg) }
)

# Pandoc with $HOME

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = paste0(Sys.getenv("HOME"), "/troubleshooting_pandoc.html")),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc $HOME/troubleshooting_pandoc.html -o test_pdf_pandoc_home.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
