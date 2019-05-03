context("limpieza")

check_api <- function() {
  if (not_working()) {
    skip_if_offline(host = "r-project.org")
  }
}
Sys.setenv(pipelineid = "3504965832666975645900460114637")

testthat::test_that("listas son eliminadas de datos de contactos", {
  check_api()
  api_token <- Sys.getenv("api_token")
  user_code <- Sys.getenv("CODIGO_USUARIO")
  pipelineid <- Sys.getenv("pipelineid")

  limpieza <- get_pipeline_report(api_token = api_token,
                                  user_code = user_code,
                                  pipelineid = pipelineid)

})

