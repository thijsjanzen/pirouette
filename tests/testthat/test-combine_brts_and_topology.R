context("test-combine_brts_and_topology")

test_that("check usage with brts coming from the same tree", {

  # Branching times as 3 (crown age) and 2 (branch of A and B) time units ago
  phylogeny <- ape::read.tree(text = "((A:2, B:2):1, C:3);")
  expect_equal(c(3, 2), as.numeric(ape::branching.times(phylogeny)))
  expect_equal(
    2,
    ape::dist.nodes(phylogeny)[1, ape::getMRCA(phylogeny, c("A", "B"))]
  )

  # Create a new phylogeny with the same topology, but with
  # branching times at 5 (crown age) and 4 (branch of A and B) time units ago
  new_phylogeny <- combine_brts_and_topology(
    brts = c(5, 4),
    tree = phylogeny
  )
  expect_equal(c(5, 4), as.numeric(ape::branching.times(new_phylogeny)))
  expect_equal(
    4,
    ape::dist.nodes(new_phylogeny)[1, ape::getMRCA(new_phylogeny, c("A", "B"))]
  )
})


test_that("check usage with brts coming from the same tree", {

  max_seed <- 5
  for (seed in 1:max_seed) {
    tree <- load_tree(seed = seed)
    brts <- pirouette:::convert_tree2brts(tree)

    test <- combine_brts_and_topology(
      brts = brts,
      tree = tree
    )

    testthat::expect_true(
      all(test$edge == tree$edge)
    )
    testthat::expect_true(
      all(test$Nnode == tree$Nnode)
    )
    testthat::expect_true(
      all(test$tip.label == tree$tip.label)
    )
    testthat::expect_true(
      all(test$root.edge == tree$root.edge)
    )
    testthat::expect_true(
      max(unname(test$edge.length) - tree$edge.length) <
        max(tree$edge.length * 1e-6)
    )
  }
})

test_that("all the tree features (but the branching times) are preserved", {

  max_seed <- 5
  for (seed in 1:max_seed) {
    tree <- load_tree(tree_model = "mbd", seed = seed)

    brts <- sort(c(
      age <- max(pirouette:::convert_tree2brts(tree)),
      runif(
        n = (length(pirouette:::convert_tree2brts(tree)) - 1),
        min = 0,
        max = age - 0.001)
    ),
    decreasing = TRUE)

    test <- combine_brts_and_topology(
      brts = brts,
      tree = tree
    )

    testthat::expect_true(
      all(test$edge == tree$edge)
    )
    testthat::expect_true(
      all(test$Nnode == tree$Nnode)
    )
    testthat::expect_true(
      all(test$tip.label == tree$tip.label)
    )
    testthat::expect_true(
      all(test$root.edge == tree$root.edge)
    )
  }
})

test_that("abuse", {

  tree <- load_tree(tree_model = "mbd", seed = 1)
  brts0 <- pirouette:::convert_tree2brts(tree)
  brts <- brts0[1:floor(length(brts0) / 2)]

  testthat::expect_error(
    combine_brts_and_topology(
      brts = brts,
      tree = tree
    ),
    "brts must be same length as number of nodes on input tree"
  )
})
