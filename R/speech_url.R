#' @title url vectors
#' @description Allows to create a vector of url to download within a period within a legislature.
#' @param chamber chamber:
#'     \describe{
#'              \item{S}{Camara de Senadores}
#'              \item{D}{Camara de Representantes (Diputados)}
#'              \item{A}{Asamblea General}
#'              \item{C}{Comision Permanente}
#'             }
#' @param from character vector. Date in YYYY-MM-DD format
#' @param to character vector. Date in YYYY-MM-DD format
#' @param days character vector. Date in YYYY-MM-DD format.
#' @return character vector
#' @examples
#' # speech_url(chamber = "D",
#' #            from    = "2015-02-15",
#' #            to      = "2015-03-15")
#' #
#' # speech_url(chamber = "D",
#' #            from    = "2015-02-15",
#' #            to      = "2015-03-15")
#' #
#' # speech_url(chamber = "D",
#' #            days   = "2015-02-15")
#' #
#' # speech_url(chamber = "D",
#' #            days    = c("2002-06-12", "2004-04-14"))
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

    url <-  url %>% purrr::map(~ .x %>% deepPDF()) %>% unlist() %>% c2()

    if(is.null(url)){
        stop("There are no sessions in that date range.", call. = FALSE)
    }
    return(url)

}



