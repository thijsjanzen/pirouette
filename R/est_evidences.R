#' Estimate the evidences
#' @inheritParams default_params_doc
#' @return a data frame with evidences
#' @export
#' @author Richel J.C. Bilderbeek
est_evidences <- function(
  fasta_filename,
  model_select_params,
  experiments = list(create_experiment())
) {
  testit::assert(file.exists(fasta_filename))

  # Estimate marginal likelihoods if needed
  marg_liks <- NULL
  if (length(model_select_params) == 314) { # nolint use new interface
    marg_liks <- est_evidences_new_skool(
      fasta_filename = fasta_filename,
      experiments = experiments
    )
  } else {
    marg_liks <- est_evidences_old_skool(
      fasta_filename = fasta_filename,
      model_select_params = model_select_params
    )
  }
  marg_liks
}

#' Estimate the evidences
#' @inheritParams default_params_doc
#' @param evidence_epsilon relative error in estimating the
#'   evidence (aka marginal likelihood).
#'   TODO: put in \code{misc_params},
#' @param evidence_filename filename to store the estimated
#'   evidences (aka marginal likelihoods)
#' @return a data frame with evidences
#' @export
#' @author Richel J.C. Bilderbeek
est_evidences_new_skool <- function(
  fasta_filename,
  experiments = list(create_experiment()),
  evidence_epsilon = 1e-12,
  evidence_filename = tempfile(fileext = ".csv")
) {
  testit::assert(file.exists(fasta_filename))
  check_experiments(experiments) # nolint pirouette function
  inference_models <- list()
  beast2_optionses <- list()

  testit::assert(length(inference_models) == length(beast2_optionses))
  marg_liks <- mcbette::est_marg_liks_from_models(
    fasta_filename = fasta_filename,
    inference_models = inference_models,
    beast2_optionses = beast2_optionses,
    epsilon = evidence_epsilon
  )
  utils::write.csv(
    x = marg_liks, file = evidence_filename
  )
}

#' Estimate the evidences old skool
#' @inheritParams default_params_doc
#' @return a data frame with evidences
#' @export
#' @author Richel J.C. Bilderbeek
est_evidences_old_skool <- function(
  fasta_filename,
  model_select_params
) {
  testit::assert(file.exists(fasta_filename))

  # Estimate marginal likelihoods if needed
  marg_liks <- NULL
  # Use old interface
  for (model_select_param in model_select_params) {
    if ("most_evidence" %in% model_select_param$type) {
      marg_liks <- mcbette::est_marg_liks(
        fasta_filename = fasta_filename,
        site_models = model_select_param$site_models,
        clock_models = model_select_param$clock_models,
        tree_priors = model_select_param$tree_priors,
        epsilon = model_select_param$epsilon,
        verbose = model_select_param$verbose
      )
      utils::write.csv(
        x = marg_liks, file = model_select_param$marg_lik_filename
      )
    }
  }
  marg_liks
}