% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_twin_branching_times.R
\name{create_twin_branching_times}
\alias{create_twin_branching_times}
\title{Generate twin branching times given estimated lambda and mu and the original
  tree}
\usage{
create_twin_branching_times(seed, lambda, mu, phylogeny, n_replicates,
  method)
}
\arguments{
\item{seed}{a random number generator seed}

\item{lambda}{per-lineage speciation rate}

\item{mu}{per-species extinction rate}

\item{phylogeny}{a phylogeny of class \link[ape]{phylo}}

\item{n_replicates}{number of replicas to evaluate in order to create the
twin tree}

\item{method}{determines how to create the twin tree
\itemize{
    \item 'random_tree' just produces a random tree;
    \item 'max_clade_cred' simulates \code{n_replicates} trees and
      uses \link[phangorn]{maxCladeCred} to create a consensus tree;
    \item 'max_likelihood' simulates \code{n_replicates} trees
     and selects the most likely;
  }}
}
\value{
twin branching times
}
\description{
Generate twin branching times given estimated lambda and mu and the original
  tree
}
\examples{
phylogeny <- ape::read.tree(text = "(((A:1, B:1):1, C:2):1, D:3);")

branching_times <- create_twin_branching_times(
  seed = 314,
  lambda = 0.1,
  mu = 1.0,
  phylogeny = phylogeny,
  n_replicates = 1,
  method = "random_tree"
)

library(testthat)
expect_equal(
  length(ape::branching.times(phylogeny)),
  length(branching_times)
)
}
\author{
Giovanni Laudanno, Richèl J.C. Bilderbeek
}
