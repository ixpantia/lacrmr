#' @import magrittr
NULL

#'
#' @title search_contacts
#'
#' @description Return the contacts information from Less annoying CRM.
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param search_term The contact name or other term to make an specific call
#' to the API. If you  want to search for group enter "Group:GROUP_NAME"
#'
#'
#' @examples
#'\dontrun{
#'search_contacts(user_code = "6A6E88",
#'                api_token = "TQ9XM",
#'                search_term = "brenesii")
#'}
#'
#' @export
search_contacts <- function(user_code, api_token, search_term = "") {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else {
    tryCatch(
      {
        r <- get_request(user_code = user_code,
                         api_token = api_token,
                         api_function = 'SearchContacts',
                         ... = search_term)
      })

        contenido <- httr::content(r, "text", encoding = "UTF-8")
        contenido <- jsonlite::fromJSON(contenido)
        contenido <- as.data.frame(contenido)

        # Pull only contact names, otherwise this will pull a nested list of
        # companies where users were assigned as independent contacts
        contenido <- contenido %>%
          filter(!is.na(Result.FirstName))

        contenido <- janitor::clean_names(contenido) %>%
          rename_with(~stringr::str_remove(., "result_"))


        # Clean PHONE ---------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$phone[i][(length(contenido$phone[[i]]$Text) == 0)] <-
            list(data.frame("Text" = NA, "Type" = NA,
                            "Clean" = NA, "TypeId" = NA))
        }

        phone <- bind_rows(contenido$phone)

        # phone <- do.call(rbind.data.frame, contenido$phone)
        # phone <- phone %>%
        #   select(Text, Type) %>%
        #   select(phone_numer = Text,
        #          phone_type = Type)

        # Clean MAIL ----------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$email[i][(length(contenido$email[[i]]$Text) == 0)] <-
            list(data.frame("Text" = NA, "Type" = NA, "TypeId" = NA))
        }




        # TODO: Ref #78
        # # check email
        # for (i in 1:nrow(contenido)) {
        #   # print(i)
        #   print(
        #     paste(nrow(contenido[[9]][[i]]), "en linea", i)
        #     )
        # }
        #

        # email <- do.call(rbind.data.frame, contenido$email)
        # email <- email %>%
        #   select(Text, Type) %>%
        #   select(email = Text, email_type = Type)


        # Clean ADDRESS -------------------------------------------------------
        # TODO// See ticket #41


        # Clean WEBSITE -------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$website[i][(length(contenido$website[[i]]$Text) == 0)] <-
            list(data.frame("Text" = NA, "Type" = NA, "TypeId" = NA))
        }

        website <- bind_rows(contenido$website)

        # row_1 <- contenido[[11]][[1]]
        # row_2 <- contenido[[11]][[2]]
        # bind_rows(row_1, row_2)

        # one <- starwars[1:4, ]
        # two <- starwars[9:12, ]
        # bind_rows(list(a = one, b = two), .id = "id")


        #
        # website <- do.call(rbind.data.frame, contenido$website) %>%
        #   select(website = Text)


        # Clean final data frame ----------------------------------------------
        contenido <- bind_cols(contenido, phone, email, website) %>%
          select(-email, -phone, -website, -address,
                 -contact_custom_fields, -custom_fields)

        return(contenido)
  }
}
