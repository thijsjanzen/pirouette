#' Checks if inference conditions are valid
#' as created by \link{create_inference_conditions}.
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing. Will \link{stop} if not
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_silent(check_inference_conditions(create_inference_conditions()))
#'   expect_error(check_inference_conditions("nonsense"))
#'   expect_error(check_inference_conditions(NA))
#'   expect_error(check_inference_conditions(NULL))
#' @export
check_inference_conditions <- function(
  inference_conditions
) {
  argument_names <- c(
    "model_type",
    "run_if",
    "do_measure_evidence"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(inference_conditions)) {
      stop(
        "'", arg_name, "' must be an element of an 'inference_conditions'. ",
        "Tip: use 'create_inference_conditions'"
      )
    }
  }
  if (!inference_conditions$model_type %in% c("generative", "candidate")) {
    stop("'model_type' must be either \"generative\" or \"candidate\"")
  }
  if (!inference_conditions$run_if %in% c("always", "best_candidate")) {
    stop("'run_if' must be either \"always\" or \"best_candidate\"")
  }
  if (!inference_conditions$do_measure_evidence %in% c(TRUE, FALSE)) {
    stop("'do_measure_evidence' must be either TRUE or FALSE")
  }
  if (inference_conditions$run_if == "best_candidate" &&
      inference_conditions$do_measure_evidence == FALSE) {
    stop(
      "'run_if' == 'best_candidate' and 'do_measure_evidence' == FALSE ",
      "is a configuration that makes no sense"
    ) # nolint
  }
  if (inference_conditions$run_if == "always" &&
      inference_conditions$model_type == "candidate") {
    stop(
      "'run_if' == 'always' and 'model_type' == 'candidate' ",
      "is a configuration that makes no sense"
    ) # nolint
  }
}
