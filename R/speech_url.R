

#Cuerpo
#S - Senadores
#D - Diputados
#A - Asamblea General
#C - Comisión Permanente


speech_url <- function(camara, legislatura, desde, hasta){

  paginas <- as.character(c(0:20))

  url <- purrr::map(paginas,~ paste0("https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion?Cpo_Codigo_2=",camara,"&Lgl_Nro=",legislatura,"&DS_Fecha%5Bmin%5D%5Bdate%5D=",desde,"&DS_Fecha%5Bmax%5D%5Bdate%5D=",hasta,"&Ssn_Nro=&TS_Diario=&tipoBusqueda=T&Texto=&page=", .))%>%
    unlist() %>%
    purrr::map(~ .x  %>%
          rvest::read_html() %>%
          rvest::html_nodes(".views-field-DS-File-IMG a") %>%
          rvest::html_attr("href") %>%
          purrr::map(~ paste0("https://parlamento.gub.uy", .)))%>%
    unlist()

  if(is.null(url)){
    stop("Hay errores u omisiones en los argumentos", call. = FALSE)
  }

  return(url)

}


##iterar
##discursos <- map(url,purrr:possibly(speech_build,otherwise = NULL))



