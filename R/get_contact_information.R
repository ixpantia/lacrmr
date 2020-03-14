#' @import magrittr
#'
#' @title get_contact_information
#'
#' @description Return the contact information.
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param contact_id The contact name or other term to make an specific call
#' to the API.
#'
#' @export
get_contact_information <- function(user_code, api_token, contact_id = "") {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else
    tryCatch({

      r <- get_request(user_code = user_code,
                       api_token = api_token,
                       api_function = 'GetContact',
                       ... = contact_id)
    })


      contenido <- httr::content(r, "text")
      contenido <- jsonlite::fromJSON(contenido,
                                      simplifyVector = TRUE)

      jsonlite::toJSON(contenido, pretty = TRUE)

      # Sobre este segmento se corre prueba manteniendo igualdad en función
      # creada para este fin
      for (i in 1:length(contenido$Contact)) {
        # print(contenido[["Contact"]][[i]])
        contenido$Contact[i][(is.null(contenido$Contact[[i]]) == TRUE)] <- NA
        contenido$Contact[i][(sjmisc::is_empty(contenido$Contact[[i]]) == TRUE)] <- NA
        contenido$Contact[i][(contenido$Contact[[i]] == "")] <- NA
      }

      contenido <- as.data.frame(contenido) %>%
        dplyr::select(-Success) %>%
        janitor::clean_names()

      return(contenido)

}

