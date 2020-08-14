#' @import magrittr
NULL

#'
#' @title get_pipeline_report
#'
#' @description Return your pipeline report information from Less annoying CRM.
#'
#' @details For this you will need to know the pipelineId, StatusId, and CustomFieldId
#' You can get this PipelineId's at https://www.lessannoyingcrm.com/app/Settings/Api'
#'
#' @param user_code The user code to identify your account
#' @param api_token The api token to connect to your account
#' @param pipelineid The id of the pipeline you want to get the report from
#'
#' @export
get_pipeline_report <- function(user_code, api_token, pipelineid) {
  if (missing(user_code)) {
   warning("Please add a valid user code")
  } else if (missing(api_token)) {
    warning("Please add a valid API token")
  } else if (missing(pipelineid)) {
    warning("Please add a valid pipeline ID")
  } else {

    tryCatch({
        r <- get_request(user_code = user_code,
                         api_token = api_token,
                         api_function = "GetPipelineReport",
                         ... = pipelineid)
      })

        contenido <- jsonlite::fromJSON(httr::content(r, "text"),
                                        simplifyVector = TRUE)

        if (length(contenido$Error) == 1) {
          if (stringr::str_detect(contenido$Error, "Invalid user credentials") == TRUE) {
            stop("Invalid user credentials. Please check your user code or your api token",
                 call. = FALSE)
          }
        }

        if (length(contenido$Error) == 1) {
          if (stringr::str_detect(contenido$Error, "Your account is not active") == TRUE) {
            stop("Your account is not active. Please contact lacrm",
                 call. = FALSE)
          }
        }

        contenido <- as.data.frame(contenido)
        contenido <- jsonlite::flatten(contenido)

        if (length(contenido$Error) == 1) {
          if (stringr::str_detect(contenido$Error, "You don't have permission to view PipelineId") ==
              TRUE) {
            stop("Invalid pipelineid. Please check your pipelineid",
                 call. = FALSE)
          }
        }

        # Clean data frame variable names.
        contenido <- janitor::clean_names(contenido)

        # Select variables of interest
        contenido <- contenido %>%
          dplyr::select(-result_email, -result_phone, -result_address,
                 -result_website, -result_contact_custom_fields)

        return(contenido)
  }
}

