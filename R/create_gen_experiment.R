#' Create a valid testing \link{pirouette} generative experiment.
#' @inheritParams default_params_doc
#' @return a \link{pirouette} experiment.
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' # Create a candidate experiment
#' experiment <- create_cand_experiment()
#' expect_true("inference_conditions" %in% names(experiment))
#' expect_true("inference_model" %in% names(experiment))
#' expect_true("beast2_options" %in% names(experiment))
#' expect_true("est_evidence_mcmc" %in% names(experiment))
#' expect_true("beast2_bin_path" %in% names(experiment))
#' expect_silent(check_experiment(experiment))
#'
#' # Create a generative experiment
#' experiment <- create_gen_experiment()
#' expect_true("inference_conditions" %in% names(experiment))
#' expect_true("inference_model" %in% names(experiment))
#' expect_true("beast2_options" %in% names(experiment))
#' expect_true("est_evidence_mcmc" %in% names(experiment))
#' expect_true("beast2_bin_path" %in% names(experiment))
#' expect_silent(check_experiment(experiment))
#'
#' # Use the experiment to create the full pirouette parameter set
#' pir_params <- create_pir_params(
#'   alignment_params = create_alignment_params(),
#'   experiments = list(experiment)
#' )
#'
#' \dontrun{
#'   pir_out <- pir_run(
#'     phylogeny = ape::read.tree(text = "((A:2, B:2):1, C:3);"),
#'     pir_params = pir_params
#'   )
#'   pir_plot(pir_out)
#' }
#' @export
create_gen_experiment <- function(
  inference_conditions = create_inference_conditions(),
  inference_model = beautier::create_inference_model(
    mcmc = beautier::create_mcmc(store_every = 1000)
  ),
  beast2_options = beastier::create_beast2_options()
) {
  create_experiment( # nolint pirouette function
    inference_conditions = inference_conditions,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}
