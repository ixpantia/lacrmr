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

# TODO// recordar que en los llamados para el api, practicamente lo que cambia
# es la function del llamado, lo demas se mantendria igual. Se podria crear
# una funcione que guarde los datos del usuario para que luego solo sea
# necesario especificar la funcion. O bien, unicamente con el nombre de la
# funcion ya deberia de ser innecesario especificar el parametro en los
# argumentos y se podria dejar fijo dentro de la funcion.
get_contacts <- function(url, user_code, api_token) {

}

modify_url(url, path = user_code)





# $EndpointURL?UserCode=$UserCode&APIToken=$APIToken

r <- GET("https://api.lessannoyingcrm.com?UserCode=6EBF0&APIToken=GCQB7XPQNR1Z5BRV2XMHM0PFGCFQJGFZK8MP98SY0TWSCVJK88&Function=SearchContacts")
contenido <- content(r, "text")
contenido <- fromJSON(contenido)
contenido <- as.data.frame(contenido)
headers(r)
