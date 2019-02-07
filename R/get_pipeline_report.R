#' @import dplyr
#'
#' @title get_pipeline_report
#'
#' @description Return your pipeline report information from Less annoying CRM.
#' For this you will need to know the pipelineId, StatusId, and CustomFieldId
#' You can get this PipelineId's at https://www.lessannoyingcrm.com/app/Settings/Api#'
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#' @export
get_pipeline_report <- function(user_code, api_token, pipelineid) {
  if (missing(user_code)) {
   warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else if (missing(pipelineid)) {
    warning("Please add a valid pipeline ID")
  } else
    tryCatch(
      {
        lacrm_url <- "https://api.lessannoyingcrm.com"

        r <- httr::GET(lacrm_url, query = list(
          UserCode = user_code,
          APIToken = api_token,
          Function = 'GetPipelineReport',
          Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
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

# api_token <- Sys.getenv("api_token")
# user_code <- Sys.getenv("user_code")
# pipelineid = Sys.getenv("pipelineid")
