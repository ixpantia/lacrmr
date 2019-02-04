
#' @title get_pipeline_report
#'
#' @description Return your pipeline report information from Less annoying CRM.
#' For this you will need to know the pipelineId, StatusId, and CustomFieldId
#' You can get this PipelineId's at https://www.lessannoyingcrm.com/app/Settings/Api
#'
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_account_information <- function(user_code, api_token, pipelineid) {
  lacram_url <- "https://api.lessannoyingcrm.com"

  r <- httr::GET(lacram_url, query = list(
    UserCode = user_code,
    APIToken = api_token,
    Function = 'GetPipelineReport',
    Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
    )
  )

  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}

api_token <- Sys.getenv("api_token")
user_code <- Sys.getenv("user_code")
pipelineid = Sys.getenv("pipelineid")





# Prueba debe de ser que si no hay un parametro bien identificado el cuadro
# final va a tener una columna que se llama "succes" y va a contener failure
