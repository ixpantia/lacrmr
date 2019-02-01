#'
#' @description Return your user account information from Less annoying CRM
#' @title get_contacts
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_account_information <- function(user_code, api_token) {
  llamado <- paste0("https://api.lessannoyingcrm.com?", "UserCode=", user_code,
                    "&APIToken=", api_token, "&Function=GetUserInfo")
  r <- httr::GET(llamado)
  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}



