
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
get_account_information <- function(user_code, api_token, pipelineId) {
  llamado <- paste0("https://api.lessannoyingcrm.com?", "UserCode=", user_code,
                    "&APIToken=", api_token, "&Function=GetPipelineReport")
  r <- httr::GET(llamado,
                 query = list(
                   PipelineId = pipelineId
                 )
  )
  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}

pipelineId <- 3571432457735893289690341276529


# Prueba debe de ser que si no hay un parametro bien identificado el cuadro
# final va a tener una columna que se llama "succes" y va a contener failure
