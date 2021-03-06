% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_pir_params.R
\name{create_pir_params}
\alias{create_pir_params}
\title{Create the parameters for \link{pirouette}}
\usage{
create_pir_params(alignment_params, twinning_params = NA,
  experiments = list(create_experiment()),
  error_measure_params = create_error_measure_params(),
  evidence_filename = tempfile(pattern = "evidence_", fileext = ".csv"),
  verbose = FALSE)
}
\arguments{
\item{alignment_params}{parameters to simulate an alignment,
as can be created by \link{create_alignment_params}}

\item{twinning_params}{can be \code{NA} if no twinning is desired,
or can be the twinning parameters,
as can be created by \link{create_twinning_params}}

\item{experiments}{a list of one or more \link{pirouette} experiments,
as can be created by \link{create_experiment}. If more than one experiment
is provided and a "generative" experiment is part of them, the "generative"
one has to be the first in the list.}

\item{error_measure_params}{parameter set to specify how the
error between the given phylogeny and the Bayesian
posterior is determined.
Use \link{create_error_measure_params} to create such
a parameter set}

\item{evidence_filename}{filename to store the estimated
evidences (aka marginal likelihoods)}

\item{verbose}{if TRUE, show more output}
}
\value{
a list with all \link{pirouette} parameters
}
\description{
Create the parameters for \link{pirouette}
}
\examples{
library(testthat)

# Create all elements to create a pirouette parameter set
alignment_params <- create_test_alignment_params()
twinning_params <- create_twinning_params()
experiments <- list(create_test_gen_experiment())
error_measure_params <- create_error_measure_params()
evidence_filename <- tempfile(fileext = ".csv")
verbose <- FALSE

# Create the pirouette parameter set
pir_params <- create_pir_params(
  alignment_params = alignment_params,
  twinning_params = twinning_params,
  experiments = experiments,
  error_measure_params = error_measure_params,
  evidence_filename = evidence_filename,
  verbose = verbose
)

expect_equal(alignment_params, pir_params$alignment_params)
expect_equal(twinning_params, pir_params$twinning_params)
expect_equal(experiments, pir_params$experiments)
expect_equal(error_measure_params, pir_params$error_measure_params)
expect_equal(evidence_filename, pir_params$evidence_filename)
expect_equal(verbose, pir_params$verbose)

# Run that experiment on a continuous integration service,
# only when BEAST2 is unstalled
if (is_on_ci() && is_beast2_installed()) {
  pir_out <- pir_run(
    phylogeny = ape::read.tree(text = "((A:2, B:2):1, C:3);"),
    pir_params = pir_params
  )
  pir_plot(pir_out)
}
}
\seealso{
Use \link{pir_run} to run the \link{pirouette} pipeline
}
\author{
Giovanni Laudanno, Richèl J.C. Bilderbeek
}
