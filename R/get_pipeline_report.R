#' @import dplyr
#'
#' @title get_pipeline_report
#'
#' @description Return your pipeline report information from Less annoying CRM.
#' For this you will need to know the pipelineId, StatusId, and CustomFieldId
#' You can get this PipelineId's at https://www.lessannoyingcrm.com/app/Settings/Api'
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param pipelineid The id of the pipeline you want to get the report from
#'
#' @export
get_pipeline_report <- function(user_code, api_token, pipelineid) {
  if (missing(user_code)) {
   warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else if (missing(pipelineid)) {
    warning("Please add a valid pipeline ID")
  } else
    tryCatch(
      {
        lacrm_url <- "https://api.lessannoyingcrm.com"

        r <- httr::GET(lacrm_url, query = list(
          UserCode = user_code,
          APIToken = api_token,
          Function = 'GetPipelineReport',
          Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
        )
        )

        contenido <- httr::content(r, "text")
        contenido <- jsonlite::fromJSON(contenido,
                                        simplifyVector = TRUE)
        contenido <- as.data.frame(contenido)
        contenido <- jsonlite::flatten(contenido)


        # Limpiar nombres del data frame
        contenido <- janitor::clean_names(contenido)

        contenido <- contenido %>%
          select(-result_email, -result_phone, -result_address,
                 -result_website, -result_contact_custom_fields)

        return(contenido)
      }
    )

}
