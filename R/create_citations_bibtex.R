#' Creates the full list of citations
#' @return an characterVector of all citations
#' @author Richel Bilderbeek
#' @export
create_citations_bibtex <- function() {
  my_text <- c(
    toBibtex(citation()),
    toBibtex(citation(package = "ape")),
    toBibtex(citation(package = "ggplot2")),
    toBibtex(citation(package = "gridExtra")),
    toBibtex(citation(package = "nLTT")),
    toBibtex(citation(package = "testit")),
    toBibtex(citation(package = "tools")),
    toBibtex(citation(package = "PBD")),
    toBibtex(citation(package = "phangorn")),
    toBibtex(citation(package = "PBD")),
    "@Manual{,",
    "  title = {rBEAST},",
    "  author = {olli0601},",
    "}"
  )
  my_text
}
