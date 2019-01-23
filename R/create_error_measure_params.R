#' Create the parameters to specify hwo the error
#' between teh given phylogeny and the Bayesian posterior trees is measured.
#' @inheritParams default_params_doc
#' @return an error measurement parameter set
#' @examples
#'  # Default
#'  error_measure_params <- create_error_measure_params()
#'  testit::assert("burn_in_fraction" %in% names(error_measure_params))
#'  testit::assert("error_function" %in% names(error_measure_params))
#'
#'  # Use the nLTT statistic with a burn-in of 10%
#'  error_measure_params <- create_error_measure_params(
#'    burn_in_fraction = 0.1,
#'    error_function = get_nltt_error_function()
#'  )
#'
#'  # Use the gamma statistic with a burn-in of 20%
#'  error_measure_params <- create_error_measure_params(
#'    burn_in_fraction = 0.2,
#'    error_function = get_gamma_error_function()
#'  )
#' @export
#' @author Richel J.C. Bilderbeek
create_error_measure_params <- function(
  burn_in_fraction = 0.1,
  error_function = get_nltt_error_function()
) {
  error_measure_params <- list(
    burn_in_fraction = burn_in_fraction,
    error_function = error_function
  )
  check_error_measure_params(error_measure_params = error_measure_params) # nolint pirouette function
  error_measure_params
}