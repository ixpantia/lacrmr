#' @import magrittr
NULL

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
#' @examples
#'\dontrun{
#'get_contact_information(user_code = "6A6E88",
#'                        api_token = "TQ9XM",
#'                        contact_id = "Fulano")
#'}
#'
#' @export
get_contact_information <- function(user_code, api_token, contact_id = "") {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else if (missing(contact_id)) {
    warning("Please add a contact id")
  } else {

    tryCatch({
      r <- get_request(user_code = user_code,
                       api_token = api_token,
                       api_function = "GetContact",
                       ... = contact_id)
    })

    content <- httr::content(r, "text")
    validate_json <- jsonlite::validate(content)

    print(validate_json)

    if (validate_json == FALSE) {
      stop("Invalid user credentials or contact ID.\n Please check your user code or your api token")
    }

    contact_info <- jsonlite::fromJSON(content, simplifyVector = TRUE)

    if (contact_info$Success[1] == FALSE) {
      stop("Invalid user credentials or contact ID.\n Please check your user code or your api token")
    }

    print(contact_info)

      for (i in 1:length(contact_info$Contact)) {
        contact_info$Contact[i][(is.null(contact_info$Contact[[i]]) == TRUE)] <- NA
        contact_info$Contact[i][(sjmisc::is_empty(contact_info$Contact[[i]]) == TRUE)] <- NA
        contact_info$Contact[i][(contact_info$Contact[[i]] == "")] <- NA
      }

      contact_info <- as.data.frame(contact_info) %>%
        dplyr::select(-Success) %>%
        janitor::clean_names()

      return(contact_info)
  }

}

