
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

  listas <- contenido %>%
    select(Result.Email, Result.Address, Result.Phone,
           Result.Website)

  #Esto lo sigue arrastrando como lista pero lo hace parecer tibble
  # email <- contenido %>%
  #   select(Result.Email) %>%
  #   bind_rows()

  email <- do.call(rbind.data.frame, contenido$Result.Email)
  website <- do.call(rbind.data.frame, contenido$Result.Website)
  phone <- do.call(rbind.data.frame, contenido$Result.Phone)
  address <- do.call(rbind.data.frame, contenido$Result.Address)

  #TODO// Pueden salir de diferente tamano, no se va a poder pegar
  tabla_listas <- data_frame(email, website, phone, address)


  return(contenido)
}

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)


