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
          contenido$phone[i][purrr::is_empty(contenido$phone[[i]])] <-
            list(data.frame("Text" = NA, "Type" = NA,
                            "Clean" = NA, "TypeId" = NA))
        }

        phone <- contenido %>%
          select(contact_id, phone) %>%
          tidyr::unnest(cols = c(phone)) %>%
          janitor::clean_names() %>%
          rename_with(~paste0("phone_", .), !starts_with("contact_id"))

        # Clean MAIL ----------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$email[i][purrr::is_empty(contenido$email[[i]])] <-
            list(data.frame("Text" = NA, "Type" = NA, "TypeId" = NA))
        }

        email <- contenido %>%
          select(contact_id, email) %>%
          tidyr::unnest(cols = c(email)) %>%
          janitor::clean_names() %>%
          rename_with(~paste0("email_", .), !starts_with("contact_id"))


        # Clean ADDRESS -------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$address[i][purrr::is_empty(contenido$address[[i]])] <-
            list(data.frame("Street" = NA,
                            "City" = NA,
                            "State" = NA,
                            "Zip" = NA,
                            "Country" = NA,
                            "Type" = NA))
        }

        address <- contenido %>%
          select(contact_id, address) %>%
          tidyr::unnest(cols = c(address)) %>%
          janitor::clean_names() %>%
          rename_with(~paste0("address_", .), !starts_with("contact_id"))


        # Clean WEBSITE -------------------------------------------------------
        for (i in 1:nrow(contenido)) {
          contenido$website[i][purrr::is_empty(contenido$website[[i]])] <-
            list(data.frame("Text" = NA, "Type" = NA, "TypeId" = NA))
        }

        website <- contenido %>%
          select(contact_id, website) %>%
          tidyr::unnest(cols = c(website)) %>%
          janitor::clean_names() %>%
          rename_with(~paste0("website_", .), !starts_with("contact_id"))

        # Clean final data frame ----------------------------------------------
        contenido <- purrr::reduce(
          list(contenido, phone, email, website, address),
          dplyr::inner_join, by = "contact_id") %>%
          select(-contact_custom_fields, -custom_fields,
                 -email, -phone, -website, -address)

        return(contenido)
  }
}
