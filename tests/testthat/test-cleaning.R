context("Cleaning")

testthat::test_that("List are removed from the pipeline report", {
  mockery::stub(where = get_pipeline_report,
                what = "jsonlite::validate",
                how = TRUE)

  mockery::stub(where = get_pipeline_report,
                what = "jsonlite::fromJSON",
                how = pipeline_data)

  pipeline_test <- get_pipeline_report(user_code = "user_code_test",
                                       api_token = "token_api_test",
                                       pipelineid = "pipeline_test")

  expect_equal(ncol(pipeline_test), 33)
  expect_equal(nrow(pipeline_test), 7)
})


testthat::test_that("Lists are removed from the contacts information", {
  mockery::stub(where = get_contact_information,
                what = "jsonlite::validate",
                how = TRUE)

  mockery::stub(where = get_contact_information,
                what = "jsonlite::fromJSON",
                how = contact_information)

  get_contact_information_test <- get_contact_information(
    user_code = "user_code_test",
    api_token = "token_api_test",
    contact_id = "123")

  expect_equal(ncol(get_contact_information_test), 20)
  expect_equal(nrow(get_contact_information_test), 1)
})
