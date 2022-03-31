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
#' @examples
#'\dontrun{
#'get_pipeline_report(user_code = "6A6E88",
#'                     api_token = "96066",
#'                     pipelineid = "57102821")
#'}
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

    content <- httr::content(r, "text")
    validate_json <- jsonlite::validate(content)

    if (validate_json[1] == FALSE) {
      stop("Invalid user credentials or pipeline ID.\n Please check your user code or your api token")
    }

    pipeline <- jsonlite::fromJSON(httr::content(r, "text", encoding = "UTF-8"),
                                    simplifyVector = TRUE)

    if (pipeline$Success[1] == FALSE) {
      stop("Invalid user credentials or pipeline ID.\n Please check your user code or your api token")
    }

    pipeline <- as.data.frame(pipeline)
    pipeline <- jsonlite::flatten(pipeline)

    # Clean data frame variable names.
    pipeline <- janitor::clean_names(pipeline)

    # Select variables of interest
    pipeline <- pipeline %>%
      dplyr::select(-result_email, -result_phone, -result_address,
                    -result_website, -result_contact_custom_fields)

    return(pipeline)
  }
}

