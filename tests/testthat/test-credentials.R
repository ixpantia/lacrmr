context("credentials")

testthat::test_that("Pipeline report error with invalid credentials", {
  skip_on_cran()
  expect_error(get_pipeline_report(user_code = "6A6E88",
                                   api_token = "96066",
                                   pipelineid = "57102821"),
     "Invalid user credentials.")
})

testthat::test_that("Account information error message with invalid credentials", {
  skip_on_cran()
  expect_error(get_account_information(user_code = "6A6E88",
                                       api_token = "FBHV7C"),
     "Invalid user credentials")
})


testthat::test_that("Contact information error message with invalid credentials", {
  skip_on_cran()
  expect_error(get_contact_information(user_code = "6A6E88",
                                       api_token = "TQ9XM",
                                       contact_id = "Fulano"))
})

testthat::test_that("Search contacts error message with invalid credentials", {
  skip_on_cran()
  expect_error(search_contacts(user_code = "6A6E88",
                               api_token = "TQ9XM",
                               search_term = "brenesii"))
})

