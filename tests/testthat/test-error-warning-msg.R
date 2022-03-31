context("Error and warning messages")

testthat::test_that("Invalid credentials", {
  expect_warning(
    get_pipeline_report(api_token = "96066",
                        pipelineid = "57102821"),
    "Please add a valid user code"
  )

  expect_error(
    get_account_information(user_code = "6A6E88",
                            api_token = "57102821"),
    "Invalid user credentials"
  )

  expect_warning(
    get_contact_information(user_code = "6A6E88",
                            contact_id = "h5jkfgns7"),
    "Please add a valid API token"
  )

  expect_warning(
    search_contacts(user_code = "6A6E88",
                    search_term = "ixpantia"),
    "Please add a valid API token"
  )
})



