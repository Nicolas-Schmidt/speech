#' @title url vectors
#' @description Allows to create a vector of url to download within a period within a legislature.
#' @param chamber chamber:
#'     \describe{
#'              \item{S}{Camara de Senadores}
#'              \item{D}{Camara de Representantes (Diputados)}
#'              \item{A}{Asamblea General}
#'              \item{C}{Comision Permanente}
#'             }
#' @param from character vector. Date in DD-MM-YYYY format
#' @param to character vector. Date in DD-MM-YYYY format
#' @author Elina Gomez \email{elina.gomez@cienciassociales.edu.uy}
#' @return character vector
#' @examples
#' # speech_url(chamber     = "D",
#' #            from        = "15-02-2015",
#' #            to          = "15-03-2015")
#' @export


speech_url <- function(chamber, from, to){

  param <- fechas_legis(from, to)
  out <- list()
  for(i in 1:length(param)){
    out[[i]] <- proto_url(chamber     = chamber,
                          legislature = names(param)[i],
                          from        = parseo(param[[i]][1]),
                          to          = parseo(param[[i]][2]))
  }
  url <- unlist(out)
  if(is.null(url)){
    stop("There are no sessions in that date range.", call. = FALSE)
  }
  return(url)

}




