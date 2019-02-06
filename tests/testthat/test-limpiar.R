context("limpieza")

testthat::test_that("listas son eliminadas de datos de contactos", {
  # TODO// como sin hacer conexion puedo probar la funcion
  api_token <- Sys.getenv("api_token")
  user_code <- Sys.getenv("user_code")
  pipelineid = Sys.getenv("pipelineid")

  limpieza <- get_pipeline_report(api_token = api_token,
                                  user_code = user_code,
                                  pipelineid = pipelineid)


})

