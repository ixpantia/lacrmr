#' GET call to lacrm API
#' @param x an integer
#' @NoRd
get_request <- function(user_code, api_token, api_function) {

  lacrm_url <- "https://api.lessannoyingcrm.com"

  r <- httr::GET(lacrm_url, query = list(
    UserCode = user_code,
    APIToken = api_token,
    Function = ,
    Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
  ))

  # if (httr::http_type(r) != "application/json") {
  #   stop("API did not return json", call. = FALSE)
  # }

  return(r)
}
