context("credentials")

testthat::test_that("Pipeline report error with invalid credentials", {
  expect_error(get_pipeline_report(user_code = "6A6E88",
                                   api_token = "96066",
                                   pipelineid = "57102821"),
     "Invalid user credentials. Please check your user code or your api token")
})

testthat::test_that("Account information error message with invalid credentials", {
  expect_error(get_account_information(user_code = "6A6E88",
                                       api_token = "FBHV7C"),
     "Invalid user credentials. Please check your user code or your api token")
})


testthat::test_that("Contact information error message with invalid credentials", {
  expect_error(get_contact_information(user_code = "6A6E88",
                                       api_token = "TQ9XM",
                                       contact_id = "Fulano"))
})

testthat::test_that("Contact information error message with invalid credentials", {
  expect_error(search_contacts(user_code = "6A6E88",
                               api_token = "TQ9XM",
                               search_term = "brenesii"))
})


# test_that("pipeline report is succesful with valid credentials", {
#   # Acceso a claves ---------------------------------------------------------
#   codigo_usuario  <- "88518"
#   token_api <- "44HK8TM1ZTFMTDTNYZ1M215DPH15D0M7310SX31F97G3P2SC3F"
#   pipelineid <- "3641868001717448079753414412494"
#
#   # Hacer conexion
#   pipeline_general <- get_pipeline_report(user_code = codigo_usuario,
#                                                   api_token = token_api,
#                                                   pipelineid = pipelineid)
# })

