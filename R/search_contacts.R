#' @import magrittr
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
        # TODO//: Si hay varios concatenados que pasan a la funcion ordenar output

        # Devolver respuesta de una manera legible al humano
        # Esto no es valido porque TRUE se refiere a si hizo la conexion
        # Es falso o verdadero si hay datos en result o no.
        # TODO//: Mejorar la lógica de esta funcion.
        if(contenido$Success == TRUE) {
          print("The search item does exists in the CRM")
        } else {
          print("There is no such item in the CRM")
        }

      }
    )

}
