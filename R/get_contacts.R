
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

  daniel$Result.Email[[1]]$Text

  for (i in 1:nrow(contenido)) {
    print(contenido$Result.Email[[i]]$Text)
  }

  contenido$Phone <- NA
  for (i in 1:nrow(contenido)) {
    print(contenido[contenido$Result.Phone[[i]]$Text == ""]) #<- NA)
    # contenido$Phone[i] <- (contenido$Result.Phone[[i]]$Text)
  }

  contenido$Phone <- NA
  prueba <- list()
  for (i in 1:nrow(contenido)) {
    prueba[i] <- (contenido$Result.Phone[[i]]$Text) #<- NA)
    # contenido$Phone[i] <- (contenido$Result.Phone[[i]]$Text)
  }

  # Asi me traigo los valores. Resta hacerlos un dataframe
  #Esto no se puede porque elimina los null y con eso el espacio
  prueba <- do.call(rbind, lapply(contenido$Result.Email, rbind))
  prueba_2 <- do.call(rbind, lapply(contenido$Result.Phone, rbind))
  prueba_3 <- do.call(rbind, lapply(listas, rbind))

  prueba_4 <- qdapTools::list_df2df(listas)

  y$series[[1]]$data <- lapply(y$series[[1]]$data,
                     function(z) { z[ lengths(z) == 0 ] <- NA; z; })

  nombres <- contenido %>%
    filter(!is.na(Result.FirstName))
  # NULL lo puedo diferenciar si tiene length cero:
  length(nombres$Result.Phone[[2]])
  # Puedo hacer un condicional que transforme lo de length cero a NA

  a <- length(nombres$Result.Phone[[2]] <- NA)

  #Este es buen condicional:
  for (i in 1:nrow(nombres)) {
    print(length(nombres$Result.Phone[[i]]) == 1)
  }

  # Intento para cambiar a NA
  for (i in 1:nrow(nombres)) {
    nombres$Result.Phone[i][(length(nombres$Result.Phone[[i]]$Text) == 0)] <- list(data.frame("Text" = NA, "Type" = NA, "Clean" = NA))
  }


2}

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)


