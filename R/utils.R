#' GET call to lacrm API
#' @param x an integer
#' @NoRd
get_request <- function(user_code, api_token, api_function) {

  lacrm_url <- "https://api.lessannoyingcrm.com"

  r <- httr::GET(lacrm_url, query = list(
    UserCode = user_code,
    APIToken = api_token,
    Function = api_function,
    Parameters = if (api_function == "PipelineId") {
      paste0('{"PipelineId":','"', pipelineid, '"', '}')
    } else if (api_function == 'SearchContacts') {
      Parameters = paste0('{"SearchTerms":','"', search_term, '"', '}')
    } else if (api_function == 'GetContact') {
      Parameters = paste0('{"ContactId":','"', contact_id, '"', '}')
    }

    # Function = 'PipelineId',
    # Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
    #
    # Function = 'SearchContacts',
    # Parameters = paste0('{"SearchTerms":','"', search_term, '"', '}')
    #
    # Function = 'GetContact',
    # Parameters = paste0('{"ContactId":','"', contact_id, '"', '}')
  ))

  # if (httr::http_type(r) != "application/json") {
  #   stop("API did not return json", call. = FALSE)
  # }

  return(r)
}


# Variacion llamados GET --------------------------------------------------
# get_pipeline_report
r <- httr::GET(lacrm_url, query = list(
  UserCode = user_code,
  APIToken = api_token,
  Function = 'GetPipelineReport',
  Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
)
)

# search_contacts
r <- httr::GET(lacrm_url, query = list(
  UserCode = user_code,
  APIToken = api_token,
  Function = 'SearchContacts',
  Parameters = paste0('{"SearchTerms":','"', search_term, '"', '}')
)
)

# get_contacts
r <- httr::GET(lacrm_url, query = list(
  UserCode = user_code,
  APIToken = api_token,
  Function = 'SearchContacts',
  Parameters = paste0('{"SearchTerms":','"', search_term, '"', '}')
)
)

# get_contact_information
lacrm_url <- "https://api.lessannoyingcrm.com"

r <- httr::GET(lacrm_url, query = list(
  UserCode = user_code,
  APIToken = api_token,
  Function = 'GetContact',
  Parameters = paste0('{"ContactId":','"', contact_id, '"', '}')
)
)


