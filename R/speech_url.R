#' @title url vectors
#' @description Allows to create a vector of url to download within a period within a legislature.
#' @param chamber chamber:
#'     \describe{
#'              \item{S}{Camara de Senadores}
#'              \item{D}{Camara de Representantes (Diputados)}
#'              \item{A}{Asamblea General}
#'              \item{C}{Comision Permanente}
#'             }
#' @param legislature legislature number
#' @param from character vector. Date in DD-MM-YYYY format
#' @param to character vector. Date in DD-MM-YYYY format
#' @author Elina Gomez \email{elina.gomez@cienciassociales.edu.uy}
#' @return character vector
#' @examples
#' # speech_url(chamber     = "D",
#' #            legislature = 48,
#' #            from        = "15-02-2015",
#' #            to          = "15-03-2015")
#' @export


speech_url <- function(chamber, legislature, from, to){

  if(test_date(from = from, to = to, legislature = legislature)){
    stop("The date range does not match the legislature.", call. = FALSE)
    }
  paginas <- as.character(c(0:20))
  url <- purrr::map(paginas,~ paste0(urlp(1),
                                     chamber,
                                     urlp(2),
                                     legislature,
                                     urlp(3),
                                     from,
                                     urlp(4),
                                     to,
                                     urlp(5), .)) %>%
    unlist() %>%
    purrr::map(~ .x  %>%
          rvest::read_html() %>%
          rvest::html_nodes(".views-field-DS-File-IMG a") %>%
          rvest::html_attr("href") %>%
          purrr::map(~ paste0("https://parlamento.gub.uy", .))) %>%
    unlist()

  if(is.null(url)){
    stop("There are no sessions in that date range.", call. = FALSE)
  }

  return(url)

}




