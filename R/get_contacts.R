
#' @title get_contacts
#'
#' @description Return the contacts information from Less annoying CRM
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_contacts <- function(user_code, api_token) {
  llamado <- paste0("https://api.lessannoyingcrm.com?", "UserCode=", user_code,
                    "&APIToken=", api_token, "&Function=SearchContacts")
  r <- httr::GET(llamado)
  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  return(contenido)
}

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)

# url <- "https://www.lessannoyingcrm.com/app/"
# url <- "https://api.lessannoyingcrm.com"
# funcion <- "GetUserInfo"

# r <- GET("https://api.lessannoyingcrm.com?UserCode=6EBF0&APIToken=GCQB7XPQNR1Z5BRV2XMHM0PFGCFQJGFZK8MP98SY0TWSCVJK88&Function=SearchContacts")

