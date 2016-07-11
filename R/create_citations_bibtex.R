#' Creates the full list of citations
#' @return an characterVector of all citations
#' @author Richel Bilderbeek
#' @export
create_citations_bibtex <- function() {
  my_text <- c(
    utils::toBibtex(utils::citation()),
    utils::toBibtex(utils::citation(package = "ape")),
    utils::toBibtex(utils::citation(package = "ggplot2")),
    utils::toBibtex(utils::citation(package = "gridExtra")),
    utils::toBibtex(utils::citation(package = "nLTT")),
    utils::toBibtex(utils::citation(package = "testit")),
    utils::toBibtex(utils::citation(package = "tools")),
    utils::toBibtex(utils::citation(package = "PBD")),
    utils::toBibtex(utils::citation(package = "phangorn")),
    utils::toBibtex(utils::citation(package = "PBD")),
    "@Manual{,",
    "  title = {rBEAST},",
    "  author = {olli0601},",
    "}"
  )
  my_text
}
