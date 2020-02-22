context("credentials")

testthat::test_that("Account information error with invalid credentials", {
  codigo_usuario <- "6A6E88"
  token_api <- "7HTQ9XM8VXPDG0XV0KMVFBHV7CCB"

  expect_error(get_account_information(user_code = codigo_usuario,
                                       api_token = token_api))
})

testthat::test_that("Account information error message with invalid credentials", {
  codigo_usuario <- "6A6E88"
  token_api <- "7HTQ9XM8VXPDG0XV0KMVFBHV7CCB"

  expect_error(get_account_information(user_code = codigo_usuario,
                                       api_token = token_api),
               "Invalid user credentials. Please check your user code or your api token")
})


testthat::test_that("Contact information error message with invalid credentials", {
  codigo_usuario <- "6A6E88"
  token_api <- "7HTQ9XM8VXPDG0XV0KMVFBHV7CCB"

  expect_error(get_account_information(user_code = codigo_usuario,
                                       api_token = token_api),
               "Invalid user credentials. Please check your user code or your api token")
})








