#' Simulates a DNA alignment and saves it to a FASTA file.
#'
#' The simulation is performed by \link{sim_alignment}.
#' @inheritParams default_params_doc
#' @return nothing
#' @examples
#'  n_taxa <- 5
#'  n_base_pairs <- 4
#'  fasta_filename <- tempfile()
#'  testit::assert(!file.exists(fasta_filename))
#'  alignment <- sim_alignment_file(
#'    fasta_filename = fasta_filename,
#'    phylogeny = ape::rcoal(n_taxa),
#'    alignment_params = create_alignment_params(
#'      root_sequence = create_blocked_dna(length = n_base_pairs),
#'      mutation_rate = 0.1
#'    )
#'  )
#'  testit::assert(file.exists(fasta_filename))
#' @author Richel Bilderbeek
#' @export
sim_alignment_file <- function(
  fasta_filename,
  phylogeny,
  alignment_params
) {
  # Simulate
  alignment <- sim_alignment(
    phylogeny = phylogeny,
    alignment_params = alignment_params
  )
  # Save
  phangorn::write.phyDat(
    alignment,
    file = fasta_filename,
    format = "fasta"
  )
}