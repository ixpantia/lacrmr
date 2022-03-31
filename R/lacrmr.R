#' \code{lacrmr} package
#'
#' Connect to the Less Annoying CRM API to get your data clean and tidy.
#'
#' See the README on
#'
#' @docType package
#' @name lacramr
#' @importFrom dplyr %>%
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
utils::globalVariables(c(".", "Success", "result_email", "result_phone",
                         "result_address", "result_website",
                         "result_contact_custom_fields", "Result.FirstName",
                         "result_email", "result_phone", "result_website",
                         "filter", "select", "Text", "Type", "bind_cols",
                         "result_custom_fields", "pipeline"
                         ))
