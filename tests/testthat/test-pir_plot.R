context("test-pir_plot")

test_that("use", {

  expect_silent(pir_plot(pir_out = create_pir_run_test_output()))
})