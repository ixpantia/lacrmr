@import httr
@import jsonlite

# Estos son los parametros:
# $EndpointURL, $UserCode, $APIToken, $Function, $Parameters)

#' Trae datos de contactos del CRM

#'

url <- "https://www.lessannoyingcrm.com/app/"
user_code <- "6EBF0"
api_token <- "GCQB7XPQNR1Z5BRV2XMHM0PFGCFQJGFZK8MP98SY0TWSCVJK88"
url <- "https://api.lessannoyingcrm.com"
funcion <- "GetUserInfo"

get_contacts <- function()






$EndpointURL?UserCode=$UserCode&APIToken=$APIToken

r <- GET("https://api.lessannoyingcrm.com?UserCode=6EBF0&APIToken=GCQB7XPQNR1Z5BRV2XMHM0PFGCFQJGFZK8MP98SY0TWSCVJK88&Function=SearchContacts")
contenido <- content(r, "text")
contenido <- fromJSON(contenido)
contenido <- as.data.frame(contenido)
headers(r)
