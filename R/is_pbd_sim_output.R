#' Does not use pbd_sim()$stree, but generates these like PBD does
#' @param pbd_sim_output the argument tested to output of PBD::pbd_sim
#' @return TRUE or FALSE
#' @export
#' @author Richel Bilderbeek
is_pbd_sim_output <- function(
  pbd_sim_output
) {
  if (typeof(pbd_sim_output) != "list") return(FALSE)
  if (length(pbd_sim_output) != 9) return(FALSE)
  if (class(pbd_sim_output$tree) != "phylo") return(FALSE)
  return(TRUE)
}