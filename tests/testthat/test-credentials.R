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

## Revision paquete para mocks:

capture_requests(simplify = FALSE, {
  real_resp <- GET("http://httpbin.org/cookies/set?token=12345")
})

lacrm_url <- "https://api.lessannoyingcrm.com"

capture_requests(simplify = FALSE, {
r <- httr::GET("https://api.lessannoyingcrm.com",
               query = list(
                 UserCode = user_code,
                 APIToken = api_token,
                 Function = 'GetPipelineReport',
                 Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
  ))
})



test_that("pipeline report is succesful with valid credentials", {
  # Acceso a claves ---------------------------------------------------------
  codigo_usuario  <- "88518"
  token_api <- "44HK8TM1ZTFMTDTNYZ1M215DPH15D0M7310SX31F97G3P2SC3F"
  pipelineid <- "3641868001717448079753414412494"

  # Hacer conexion
  pipeline_general <- get_pipeline_report(user_code = codigo_usuario,
                                                  api_token = token_api,
                                                  pipelineid = pipelineid)



})




