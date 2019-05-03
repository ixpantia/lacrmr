context("limpieza")

testthat::test_that("listas son eliminadas de datos de contactos", {


  limpieza <- get_pipeline_report(api_token = api_token,
                                  user_code = user_code,
                                  pipelineid = pipelineid)

  expect_true(class(limpieza$result_contact_id) != "list")

})

