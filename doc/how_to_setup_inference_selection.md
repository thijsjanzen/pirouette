# How to set up inference selection?

With `pirouette` there are multiple ways to
select models to do an inference with.

We call each model


## 1. Only run the generative model

`model_type`|`run_if`        |`measure_evidence`|`beautier::inference_model`
------------|----------------|------------------|---------------------------
`generative`|`always`        |[irrelevant]      |`generative_model`

We assume we know the generative model, which
happens to be the BEAUti default:

```{r}
generative_model <- beautier::create_inference_model()
testit::assert(generative_model$site_model$name == "JC69")
testit::assert(generative_model$clock_model$name == "strict")
testit::assert(generative_model$tree_prior$name == "yule")
```

We create one experiment:

```
experiment <- create_experiment(
  model_type = "generative",
  run_if = "always",
  do_measure_evidence = "irrelevant",
  inference_model = generative_model
)

pir_run(
  # ...
  experiments = experiment
)
```

## 2. Only run the best of a set of models

`model_type`|`run_if`        |`measure_evidence`|`beautier::inference_model`
------------|----------------|------------------|---------------------------
`candidate` |`best_candidate`|TRUE              |`inference_model_1`
`candidate` |`best_candidate`|TRUE              |`inference_model_2`

This time we have two models that compete: a Yule and a Birth-Death model.


```{r}
inference_model_1 <- beautier::create_inference_model()
testit::assert(inference_model_1$site_model$name == "JC69")
testit::assert(inference_model_1$clock_model$name == "strict")
testit::assert(inference_model_1$tree_prior$name == "yule")

inference_model_2 <- beautier::create_inference_model(
  tree_prior = create_bd_tree_prior()
)
testit::assert(inference_model_2$site_model$name == "JC69")
testit::assert(inference_model_2$clock_model$name == "strict")
testit::assert(inference_model_2$tree_prior$name == "?birth-death")
```

We create one experiment per inference model:

```
experiment_1 <- create_experiment(
  model_type = "candidate",
  run_if = "best_candidate",
  do_measure_evidence = TRUE,
  inference_model = inference_model_1
)
experiment_2 <- create_experiment(
  model_type = "candidate",
  run_if = "best_candidate",
  do_measure_evidence = TRUE,
  inference_model = inference_model_2
)
experiments <- list(experiment_1, experiment_2)

pir_run(
  # ...
  experiments = experiments
)
```

## 3. Always run a generative model and a best candidate

`model_type`|`run_if`        |`measure_evidence`|`beautier::inference_model`
------------|----------------|------------------|---------------------------
`generative`|`always`        |TRUE              |`generative_model`
`candidate` |`best_candidate`|TRUE              |`inference_model_2`
`candidate` |`best_candidate`|TRUE              |`inference_model_3`

This time, we know the generative model:

```{r}
generative_model <- beautier::create_inference_model()
testit::assert(generative_model$site_model$name == "JC69")
testit::assert(generative_model$clock_model$name == "strict")
testit::assert(generative_model$tree_prior$name == "yule")
```

But there are two competing models, with different site models: 

```
inference_model_2 <- beautier::create_inference_model(
  site_model = create_hky_site_model()
)
testit::assert(inference_model_2$site_model$name == "HKY")
testit::assert(inference_model_2$clock_model$name == "strict")
testit::assert(inference_model_2$tree_prior$name == "yule")

inference_model_3 <- beautier::create_inference_model(
  site_model = create_tn93_site_model()
)
testit::assert(inference_model_3$site_model$name == "TN93")
testit::assert(inference_model_3$clock_model$name == "strict")
testit::assert(inference_model_3$tree_prior$name == "yule")
```

We create one experiment per inference model:

```
experiment_1 <- create_experiment(
  model_type = "generative",
  run_if = "always",
  do_measure_evidence = TRUE,
  inference_model = generative_model
)
experiment_2 <- create_experiment(
  model_type = "candidate",
  run_if = "best_candidate",
  do_measure_evidence = TRUE,
  inference_model = inference_model_2
)
experiment_3 <- create_experiment(
  model_type = "candidate",
  run_if = "best_candidate",
  do_measure_evidence = TRUE,
  inference_model = inference_model_3
)
experiments <- list(experiment_1, experiment_2, experiment_3)

pir_run(
  # ...
  experiments = experiments
)
```