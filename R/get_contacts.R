
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
  contenido <- contenido %>%
    filter(!is.na(Result.FirstName))

  nombres <- contenido %>%
    filter(!is.na(Result.FirstName))

  # Intento para cambiar a NA en data.frame
  for (i in 1:nrow(nombres)) {
    nombres$Result.Phone[i][(length(nombres$Result.Phone[[i]]$Text) == 0)] <- list(data.frame("Text" = NA, "Type" = NA, "Clean" = NA))
  }


}

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)


