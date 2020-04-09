
context("limpieza")

testthat::test_that("listas son eliminadas de datos de contactos", {
  mockery::stub(where = get_pipeline_report,
                what = "jsonlite::fromJSON",
                how = pipeline_data)

  pipeline_test <- get_pipeline_report(user_code = "user_code_test",
                                      api_token = "token_api_test",
                                      pipelineid = "pipeline_test")

 expect_equal(ncol(pipeline_test), 33)
 expect_equal(nrow(pipeline_test), 7)

})

