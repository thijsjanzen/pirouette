% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_tree.R
\name{load_tree}
\alias{load_tree}
\title{Load pre-simulated tree generated under requested model and seed}
\usage{
load_tree(tree_model = "mbd", seed = 1)
}
\arguments{
\item{tree_model}{model used to simulate the tree}

\item{seed}{a random number generator seed}
}
\description{
Load pre-simulated tree generated under requested model and seed
}
\examples{
phylogeny <- load_tree()

library(testthat)
expect_true(is_phylo(phylogeny))
}
\author{
Giovanni Laudanno, Richèl J.C. Bilderbeek
}
