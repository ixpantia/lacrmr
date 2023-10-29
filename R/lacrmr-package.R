#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr %>%
## usethis namespace: end
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
utils::globalVariables(c(".", "Success", "result_email", "result_phone",
                         "result_address", "result_website",
                         "result_contact_custom_fields", "Result.FirstName",
                         "result_email", "result_phone", "result_website",
                         "filter", "select", "Text", "Type", "bind_cols",
                         "result_custom_fields", "pipeline", "contact_id",
                         "contact_custom_fields", "custom_fields",
                         "creation_date", "edited_date"
                         ))
