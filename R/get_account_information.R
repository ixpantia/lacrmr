

#' @title get_account_information
#'
#' @description Return your user account information from Less annoying CRM
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_account_information <- function(user_code, api_token) {
  lacrm_url <- "https://api.lessannoyingcrm.com"

  r <- httr::GET(lacrm_url, query = list(
    UserCode = user_code,
    APIToken = api_token,
    Function = 'GetUserInfo'
      )
  )

  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}



