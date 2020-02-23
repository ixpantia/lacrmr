#' @import magrittr
#'
#' @title get_contacts
#'
#' @description Return the contacts information from Less annoying CRM.
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param search_term The contact name or other term to make an specific call
#' to the API. If you  want to search for group enter "Group:GROUP_NAME"
#'
#' @export
get_contacts <- function(user_code, api_token, search_term = "") {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else
    tryCatch(
      {
        r <- get_request(user_code = user_code,
                         api_token = api_token,
                         api_function = 'SearchContacts')

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


        # Limpieza PHONE ----------------------------------------------------------
        # Cambio de listas vacias por data.frame similar con
        # estructura igual a listas con entradas
        for (i in 1:nrow(contenido)) {
          contenido$result_phone[i][(length(contenido$result_phone[[i]]$Text) == 0)] <- list(data.frame("Text" = NA, "Type" = NA, "Clean" = NA))
        }

        # Aplanar lista uniforme y adjuntarla con dataframe completo por posicion
        phone <- do.call(rbind.data.frame, contenido$result_phone)
        phone <- phone %>%
          select(Text, Type) %>%
          select(phone_numer = Text, phone_type = Type)



        # Limpieza MAIL -----------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$result_email[i][(length(contenido$result_email[[i]]$Text) == 0)] <- list(data.frame("Text" = NA, "Type" = NA))
        }

        email <- do.call(rbind.data.frame, contenido$result_email)
        email <- email %>%
          select(Text, Type) %>%
          select(email = Text, email_type = Type)


        # Limpieza address --------------------------------------------------------
        # TODO// hay que arreglar esta funcion y ver como limpiarla
        #    for (i in 1:nrow(contenido)) {
        #      contenido$result_address[i][(length(contenido$result_address[[i]]$Text) == 0)] <- list(data.frame("Street" = NA,
        #                                                                                                    "City" = NA,
        #                                                                                                    "State" = NA,
        #                                                                                                    "Zip" = NA,
        #                                                                                                    "Country" = NA,
        #                                                                                                    "Type" = NA))
        #    }
        #
        #    address <- do.call(rbind.data.frame, contenido$result_address)
        #    email <- email %>%
        #      select(Text, Type) %>%
        #      select(email = Text, email_type = Type)


        # Limpieza website --------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$result_website[i][(length(contenido$result_website[[i]]$Text) == 0)] <- list(data.frame("Text" = NA))
        }

        website <- do.call(rbind.data.frame, contenido$result_website)


        # Limpiar tabla final -----------------------------------------------------

        contenido <- bind_cols(contenido, phone, email, website) %>%
          select(-result_email, -result_phone, -result_website, -result_address,
                 -result_contact_custom_fields, -result_custom_fields)
        return(contenido)
      }
    )
}

