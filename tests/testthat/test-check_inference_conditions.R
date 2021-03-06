context("test-check_inference_conditions")

test_that("use", {

  expect_silent(check_inference_conditions(create_inference_conditions()))
})

test_that("wrong parameter names", {
  inference_conditions <- create_inference_conditions()
  inference_conditions$model_type <- NULL
  expect_error(
    check_inference_conditions(
      inference_conditions
    ),
    "'model_type' must be an element of an 'inference_conditions'"
  )

  inference_conditions <- create_inference_conditions()
  inference_conditions$run_if <- NULL
  expect_error(
    check_inference_conditions(
      inference_conditions
    ),
    "'run_if' must be an element of an 'inference_conditions'"
  )

  inference_conditions <- create_inference_conditions()
  inference_conditions$do_measure_evidence <- NULL
  expect_error(
    check_inference_conditions(inference_conditions),
    "'do_measure_evidence' must be an element of an 'inference_conditions'"
  )
})

test_that("wrong parameter values", {

  expect_error(
    check_inference_conditions(
      create_inference_conditions(
        model_type = "nonsense"
      )
    ),
    "'model_type' must be either \"generative\" or \"candidate\""
  )
  expect_error(
    check_inference_conditions(
      create_inference_conditions(
        run_if = "nonsense"
      )
    ),
    "'run_if' must be either \"always\" or \"best_candidate\""
  )
  expect_error(
    check_inference_conditions(
      create_inference_conditions(
        do_measure_evidence = "nonsense"
      )
    ),
    "'do_measure_evidence' must be either TRUE or FALSE"
  )
})

test_that("incoherent settings", {

  expect_error(
    check_inference_conditions(
      create_inference_conditions(
        run_if = "best_candidate",
        do_measure_evidence = FALSE
      )
    ),
    "'run_if' == 'best_candidate' and 'do_measure_evidence' == FALSE is a configuration that makes no sense" # nolint
  )
  expect_error(
    check_inference_conditions(
      create_inference_conditions(
        run_if = "always",
        model_type = "candidate"
      )
    ),
    "'run_if' == 'always' and 'model_type' == 'candidate' is a configuration that makes no sense" # nolint
  )
})
