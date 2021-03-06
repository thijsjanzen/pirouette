% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_experiments.R
\name{select_experiments}
\alias{select_experiments}
\title{Select the experiments to do a Bayesian inference with.}
\usage{
select_experiments(experiments = list(create_test_experiment()),
  marg_liks = NULL, verbose = FALSE)
}
\arguments{
\item{experiments}{a list of one or more \link{pirouette} experiments,
as can be created by \link{create_experiment}. If more than one experiment
is provided and a "generative" experiment is part of them, the "generative"
one has to be the first in the list.}

\item{marg_liks}{a data frame with marginal likelihoods/evidences.
A test data frame can be created by \link{create_test_marg_liks}}

\item{verbose}{if TRUE, show more output}
}
\value{
a list of inference models
}
\description{
Select the experiments to do a Bayesian inference with.
}
\examples{
evidences <- create_test_marg_liks(
  site_models = list(create_jc69_site_model()),
  clock_models = list(create_strict_clock_model()),
  tree_priors = list(create_yule_tree_prior(), create_bd_tree_prior())
)
evidences$weight <- c(0.9, 0.1) # in favor of Yule

experiment_yule <- create_test_cand_experiment()
experiment_bd <- create_test_cand_experiment()
experiment_bd$inference_model$tree_prior <- create_bd_tree_prior()
experiments <- list(experiment_yule, experiment_bd)

# Select the experiment.
# In this case, select the candidate experiment with the highest evidence
selected <- select_experiments(
  experiments = experiments,
  marg_liks = evidences
)

library(testthat)
expect_equal(1, length(selected))
expect_equal("yule", selected[[1]]$inference_model$tree_prior$name)
}
\seealso{
Use \link{check_experiments} to check if an object
  is a list of experiments
}
\author{
Richèl J.C. Bilderbeek
}
