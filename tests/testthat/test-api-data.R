## Revision paquete para mocks:

capture_requests(simplify = FALSE, {
  real_resp <- GET("http://httpbin.org/cookies/set?token=12345")
})

lacrm_url <- "https://api.lessannoyingcrm.com"

capture_requests(simplify = FALSE, {
  r <- httr::GET("https://api.lessannoyingcrm.com",
                 query = list(
                   UserCode = user_code,
                   APIToken = api_token,
                   Function = 'GetPipelineReport',
                   Parameters = paste0('{"PipelineId":','"', pipelineid, '"', '}')
                 ))
})

