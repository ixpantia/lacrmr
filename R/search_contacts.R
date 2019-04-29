#' @import dplyr
#'
#' @title search_contacts
#'
#' @description Return TRUE or FALSE if the contacts information exist on
#' Less annoying CRM.
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param search_term The contact name or other term to make an specific call
#' to the API. If you  want to search for group enter "Group:GROUP_NAME"
#'
#' @export
search_contacts <- function(user_code, api_token, search_term = "") {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else
    tryCatch(
      {
        lacrm_url <- "https://api.lessannoyingcrm.com"

        r <- httr::GET(lacrm_url, query = list(
          UserCode = user_code,
          APIToken = api_token,
          Function = 'SearchContacts',
          Parameters = paste0('{"SearchTerms":','"', search_term, '"', '}')
        )
        )

        contenido <- httr::content(r, "text")
        contenido <- jsonlite::fromJSON(contenido)
        contenido <- as.data.frame(contenido)

        # Hay que traer solo nombres de contactos, de lo contrario llamado
        # trae como lista anidada empresas a las que pertenece el usuario
        # como un contacto independiente, ingresando muchos NA's que ensucian.
        contenido <- contenido %>%
          filter(!is.na(Result.FirstName))

        # Limpiar nombres del data frame
        contenido <- janitor::clean_names(contenido)

        return(contenido)
      }
    )

}
