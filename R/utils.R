#' GET call to lacrm API
#' @param user_code The User Code to identify your account
#' @param api_function The API  token to connect to your account
#' @param api_function The `Less Annoying CRM` function that you want to use in the API call
#' @noRd
get_request <- function(user_code, api_token, api_function, ...) {

  item <- paste0(...)

  if (api_function == "GetPipelineReport") {
    pipelineid <-  item
  } else if (api_function == "SearchContacts") {
    search_term <- item
  } else if (api_function == "GetContact") {
    contact_id <- item
  }

  r <- httr::GET("https://api.lessannoyingcrm.com",
                 query = list(
                  UserCode = user_code,
                  APIToken = api_token,
                  Function = api_function,
                  Parameters =  if (api_function == "GetPipelineReport") {
                    paste0('{"PipelineId":','"', pipelineid, '"', '}')
                  } else if (api_function == 'SearchContacts') {
                    paste0('{"SearchTerms":','"', search_term, '"', '}')
                  } else if (api_function == 'GetContact') {
                    paste0('{"ContactId":','"', contact_id, '"', '}')
                  }
  ))
  return(r)
}


#' Flatten nested lists
#'
#' Code based on answer on Stack Overflow:
#' https://stackoverflow.com/a/41882883/1329484
#'
#' @param nested_list A nested list to be flattened
#' @noRd
flattenlist <- function(nested_list){
  morelists <- sapply(nested_list, function(xprime) class(xprime)[1] == "list")
  out <- c(nested_list[!morelists], unlist(nested_list[morelists], recursive = FALSE))
  if (sum(morelists)) {
    Recall(out)
  }else{
    return(out)
  }
}

