#' GET call to lacrm API
#' @param x an integer
#' @NoRd
get_request <- function(user_code, api_token, api_function, ...) {

  item <- paste0(...)

  if (api_function == "GetPipelineReport") {
    pipelineid <-  item
  } else if (api_function == "SearchContacts") {
    search_term <- item
  } else if (api_function == "ContactId") {
    contact_id <- item
  }

  print(pipelineid)

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


