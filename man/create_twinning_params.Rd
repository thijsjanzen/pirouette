% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_twinning_params.R
\name{create_twinning_params}
\alias{create_twinning_params}
\title{Create the parameters for the twinning simulation}
\usage{
create_twinning_params(rng_seed = 0, twin_model = "birth_death",
  method = "random_tree", n_replicates = 10000,
  twin_tree_filename = tempfile(pattern = "tree_twin_", fileext =
  ".newick"), twin_alignment_filename = tempfile(pattern =
  "alignment_twin_", fileext = ".fasta"),
  twin_evidence_filename = tempfile(pattern = "evidence_twin_", fileext =
  ".csv"))
}
\arguments{
\item{rng_seed}{the random number generator seed as used in the
simulation of a twin tree}

\item{twin_model}{the model you want to use to generate the twin tree:
\itemize{
  \item \code{birth_death}: birth death
  \item \code{yule}: Yule or pure-birth
}
See \link{get_twin_models} to see all possible
values of \code{twin_model}}

\item{method}{determines how to create the twin tree
\itemize{
    \item 'random_tree' just produces a random tree;
    \item 'max_clade_cred' simulates \code{n_replicates} trees and
      uses \link[phangorn]{maxCladeCred} to create a consensus tree;
    \item 'max_likelihood' simulates \code{n_replicates} trees
     and selects the most likely;
  }}

\item{n_replicates}{number of replicas to evaluate in order to create the
twin tree}

\item{twin_tree_filename}{name of the (\code{.newick}) file the twin
tree will be saved to}

\item{twin_alignment_filename}{name of the FASTA file the twin
alignment will be saved to}

\item{twin_evidence_filename}{filename to store the estimated
evidences (aka marginal likelihoods) of the twin tree}
}
\value{
a twinning parameter set
}
\description{
Create the parameters for the twinning simulation.
The site model and clock models will be used and
their combination will be called the generative model
of the twinning.
}
\examples{
twinning_params <- create_twinning_params()

library(testthat)
expect_true("rng_seed" \%in\% names(twinning_params))
expect_true("twin_tree_filename" \%in\% names(twinning_params))
expect_silent(check_twinning_params(twinning_params))

pir_params <- create_test_pir_params(
  twinning_params = twinning_params
)
expect_silent(check_pir_params(pir_params))

if (is_on_ci() &&
  rappdirs::app_dir()$os == "unix" &&
  is_beast2_installed()) {
  pir_out <- pir_run(
    phylogeny = ape::read.tree(text = "((A:1, B:1):1, C:2);"),
    pir_params = pir_params
  )
}
}
\author{
Richèl J.C. Bilderbeek, Giovanni Laudanno
}
