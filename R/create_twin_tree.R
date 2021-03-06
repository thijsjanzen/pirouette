#' Create a twin tree
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek, Giovanni Laudanno
#' @examples
#' phylogeny <- ape::read.tree(text = "((A:1, B:1):1, C:2);")
#' twin_phylogeny <- create_twin_tree(phylogeny)
#'
#' library(testthat)
#' expect_true(is_phylo(twin_phylogeny))
#' @export
create_twin_tree <- function(
  phylogeny,
  twinning_params = create_twinning_params()
) {
  if (!(twinning_params$twin_model %in% get_twin_models())) {
    stop("This twin model is not implemented")
  }
  if (twinning_params$twin_model == "birth_death") {
    twin_tree <- twin_to_bd_tree(
      phylogeny = phylogeny,
      twinning_params = twinning_params
    )
  }
  if (twinning_params$twin_model == "yule") {
    twin_tree <- twin_to_yule_tree(
      phylogeny = phylogeny,
      twinning_params = twinning_params
    )
  }
  testit::assert(beautier::is_phylo(twin_tree))
  testit::assert(
    all.equal(
      max(ape::branching.times(phylogeny)),
      max(ape::branching.times(twin_tree))
    )
  )
  twin_tree
}
