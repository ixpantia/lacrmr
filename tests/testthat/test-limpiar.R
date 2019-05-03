context("limpieza")

# check_api <- function() {
#   if (not_working()) {
#     skip_if_offline(host = "r-project.org")
#   }
# }
Sys.setenv(pipelineid = "3504965832666975645900460114637")
Sys.setenv(CODIGO_USUARIO="51B03")
Sys.setenv(TOKEN_API="MDWN53XHYZJ3RW87X0XHTN9502GNCQZ92M0K6HVG3W7J70XH8Y")


testthat::test_that("listas son eliminadas de datos de contactos", {
  skip_if_offline(host = "r-project.org")
  api_token <- Sys.getenv("TOKEN_API")
  user_code <- Sys.getenv("CODIGO_USUARIO")
  pipelineid <- Sys.getenv("pipelineid")

  limpieza <- get_pipeline_report(api_token = api_token,
                                  user_code = user_code,
                                  pipelineid = pipelineid)

  expect_true(class(limpieza$result_contact_id) != "list")

})

