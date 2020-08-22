#' @import magrittr
NULL

#'
#' @title get_account_information
#'
#' @description Return your user account information from Less annoying CRM
#'
#' @details For using this function you will need to get your credentials from
#' your Less Annoying CRM. Make sure to have your user code and your api_token.
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#'
#'@examples
#'\dontrun{
#'get_account_information(user_code = "6A6E88",
#'                        api_token = "FBHV7C")
#'}
#'
#'
#' @export
get_account_information <- function(user_code, api_token) {
  if (missing(user_code)) {
    warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else
    tryCatch(
      {

        r <- get_request(user_code = user_code,
                         api_token = api_token,
                         api_function = 'GetUserInfo')
      })


  validate_json <- jsonlite::validate(httr::content(r, "text"))[1]

  if (validate_json == FALSE) {
    stop("Invalid user credentials.\n Please check your user code or your api token")
  }

  account_info <- httr::content(r, "text")
  account_info <- jsonlite::fromJSON(account_info)

  if (pipeline$Success[1] == FALSE) {
    stop("Invalid user credentials or pipeline ID.\n Please check your user code or your api token")
  }

  account_info <- as.data.frame(account_info)

  return(account_info)
}

