
#' @title get_pipeline_report
#'
#' @description Return your pipeline report information from Less annoying CRM
#'
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_account_information <- function(user_code, api_token) {
  llamado <- paste0("https://api.lessannoyingcrm.com?", "UserCode=", user_code,
                    "&APIToken=", api_token, "&Function=GetPipelineReport")
  r <- httr::GET(llamado)
  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}


r <- GET("https://api.lessannoyingcrm.com?UserCode=6EBF0&APIToken=GCQB7XPQNR1Z5BRV2XMHM0PFGCFQJGFZK8MP98SY0TWSCVJK88&Function=GetPipelineReport")
