#' Create a Yule tree
#' @inheritParams default_params_doc
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   n_taxa <- 31
#'   crown_age <- 41
#'
#'   phylogeny <- create_yule_tree(
#'     n_taxa = n_taxa,
#'     crown_age = crown_age
#'   )
#'
#'   expect_equal(n_taxa, ape::Ntip(phylogeny))
#'   expect_equal(crown_age, beautier::get_crown_age(phylogeny))
#' @export
create_yule_tree <- function(
  n_taxa = 6,
  crown_age = 10,
  n_0 = 2
) {
  diff <- (log(n_taxa) - log(n_0)) / crown_age
  mu <- 0
  lambda <- diff + mu
  sim_tree <- TESS::tess.sim.taxa.age(
    n = 1,
    lambda = lambda,
    mu     = mu,
    nTaxa = n_taxa,
    age = crown_age,
    MRCA = TRUE
  )[[1]]
  sim_tree
}

#' Create a bd tree
#' @inheritParams default_params_doc
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   n_taxa <- 31
#'   crown_age <- 41
#'
#'   phylogeny <- create_bd_tree(
#'     n_taxa = n_taxa,
#'     crown_age = crown_age
#'   )
#'
#'   expect_equal(n_taxa, ape::Ntip(phylogeny))
#'   expect_equal(crown_age, beautier::get_crown_age(phylogeny))
#' @export
create_bd_tree <- function(
  n_taxa = 6,
  crown_age = 10,
  n_0 = 2,
  mu = 0.1
) {
  diff <- (log(n_taxa) - log(n_0)) / crown_age
  lambda <- diff + mu
  sim_tree <- TESS::tess.sim.taxa.age(
    n = 1,
    lambda = lambda,
    mu     = mu,
    nTaxa = n_taxa,
    age = crown_age,
    MRCA = TRUE
  )[[1]]
  sim_tree
}
