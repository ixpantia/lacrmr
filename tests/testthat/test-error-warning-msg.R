context("Error and warning messages")

testthat::test_that("Invalid credentials", {
  expect_warning(
    get_pipeline_report(api_token = "96066",
                        pipelineid = "57102821"),
    "Please add a valid user code"
  )

  expect_warning(
    get_pipeline_report(user_code = "6A6E88",
                        pipelineid = "57102821"),
    "Please add a valid API token"
  )

  expect_warning(
    get_pipeline_report(user_code = "6A6E88",
                        api_token = "96066"),
    "Please add a valid pipeline ID"
  )
})



