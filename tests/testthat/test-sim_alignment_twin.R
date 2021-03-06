context("test-sim_alignment_twin")

test_that("use, two taxa", {

  skip("sim_alignment_twin")
  # If we can create an alignment with any desired number of
  # mutations, we can create a twin alignment:
  # just create an alignmnet with the same number of mutations
  # as the true alignment

  n_mutations <- 8

  # Tip: call 'sim_alignment_raw'!
  alignment <- sim_alignment_twin(
    phylogeny = ape::read.tree(text = "(A:4, B:4);"),
    root_sequence = "aaaaaaaa",
    rng_seed = 314,
    mutation_rate = 0.125,
    site_model = create_jc69_site_model(),
    n_mutations = n_mutations
  )
  expect_equal(
    count_n_mutation(alignment, root_sequence = root_sequence),
    n_mutations
  )
})

test_that("use, three taxa", {

  skip("sim_alignment_twin")

  n_mutations <- 12

  # Tip: call 'sim_alignment_raw'!
  alignment <- sim_alignment_twin(
    phylogeny = ape::read.tree(text = "((A:1, B:1):1, C:2);"),
    root_sequence = "aaaaaaaa",
    rng_seed = 314,
    mutation_rate = 0.25,
    site_model = create_jc69_site_model(),
    n_mutations = n_mutations
  )
  expect_equal(
    count_n_mutation(alignment, root_sequence = root_sequence),
    n_mutations
  )
})
