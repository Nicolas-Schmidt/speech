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
#' @param days character vector. Date in DD-MM-YYYY format.
#' @return character vector
#' @examples
#' # speech_url(chamber = "D",
#' #            from    = "15-02-2015",
#' #            to      = "15-03-2015")
#' #
#' # speech_url(chamber = "D",
#' #            from    = "15-02-2015",
#' #            to      = "15-02-2015")
#' #
#' # speech_url(chamber = "D",
#' #            days   = "15-02-2015")
#' #
#' # speech_url(chamber = "D",
#' #            days    = c("12-06-2002", "14-04-2004"))
#' #
#'
#' @export


speech_url <- function(chamber, from, to, days = NULL){


  if(!is.null(days)){
    url <- character()
    for(i in 1:length(days)){
      url[i] <- urls.out(chamber = chamber, from = days[i] , to = days[i])
    }
  } else{
    url <- urls.out(chamber = chamber, from = from, to = to)
  }

  if(is.null(url)){
    stop("There are no sessions in that date range.", call. = FALSE)
  }
  return(url)

}




