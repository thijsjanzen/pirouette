% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_alignment_params.R
\name{create_test_alignment_params}
\alias{create_test_alignment_params}
\title{Create testing parameters for the alignment simulation.}
\usage{
create_test_alignment_params(root_sequence = "acgt",
  mutation_rate = 0.1, site_model = beautier::create_jc69_site_model(),
  clock_model = beautier::create_strict_clock_model(), rng_seed = 0,
  fasta_filename = tempfile(pattern = "alignment_", fileext = ".fasta"))
}
\arguments{
\item{root_sequence}{the DNA sequence at the root of the phylogeny.
By default, this will consist out of an equal amount of each letter}

\item{mutation_rate}{the mutation rate per base pair per time unit}

\item{site_model}{a nucleotide substitution model,
as created by \link[beautier]{create_site_model}}

\item{clock_model}{a clock model,
as created by \link[beautier]{create_clock_model}}

\item{rng_seed}{a random number generator seed}

\item{fasta_filename}{name of a FASTA file}
}
\value{
a list of alignment parameters
}
\description{
Create testing parameters for the alignment simulation.
}
\author{
Richèl J.C. Bilderbeek
}
