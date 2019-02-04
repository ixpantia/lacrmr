
#' @title get_contacts
#'
#' @description Return the contacts information from Less annoying CRM
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_contacts <- function(user_code, api_token, contactid) {
  lacram_url <- "https://api.lessannoyingcrm.com"

  r <- httr::GET(lacram_url, query = list(
    UserCode = user_code,
    APIToken = api_token,
    Function = 'SearchContacts',
    Parameters = contactid
  )
  )

  contenido <- httr::content(r, "text")
  contenido <- jsonlite::fromJSON(contenido)
  contenido <- as.data.frame(contenido)

  correo <- contenido %>%
    filter(!is.na(Result.FirstName)) %>%
    select(Result.Email)

  return(contenido)
}

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)


