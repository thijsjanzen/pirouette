% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_experiments.R
\name{check_experiments}
\alias{check_experiments}
\title{Checks if the argument is a list of one or more \link{pirouette} experiments.}
\usage{
check_experiments(experiments)
}
\arguments{
\item{experiments}{a list of one or more \link{pirouette} experiments,
as can be created by \link{create_experiment}. If more than one experiment
is provided and a "generative" experiment is part of them, the "generative"
one has to be the first in the list.}
}
\value{
nothing. Will \link{stop} if not
}
\description{
Will \link{stop} if not.
A valid \link{pirouette} experiment
can be created by \link{create_experiment}.
}
\examples{
  library(testthat)

  expect_silent(check_experiments(list(create_test_experiment())))
  expect_error(check_experiments(create_test_experiment()))
  expect_error(check_experiments("nonsense"))
  expect_error(check_experiments(NA))
  expect_error(check_experiments(NULL))
}
\seealso{
Use \link{check_experiment} to check if an object
  is one valid experiment
}
\author{
Richèl J.C. Bilderbeek
}
