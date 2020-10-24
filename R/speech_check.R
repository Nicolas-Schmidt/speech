#' @title Check the names of legislators
#' @description It allows to check that the names of the legislators are
#'     correctly written before compiling the documents in \code{speech_build}.
#' @param tidy_speech data.frame.
#' @param initial character vector. Initial of the legislators' names. If no
#'     initial is entered, all will be checked.
#' @param expand logical. If \code{TRUE}, the legislature to which the name of the legislator
#'     belongs is shown. By default By default is \code{FALSE}.
#' @return list with a data.frame for each initial of legislators' names.
#' @examples
#' \donttest{
#' url <- "http://bit.ly/35AUVF4"
#' out <- speech_build(file = url)
#' speech_check(out, initial = c("A", "M"), expand = FALSE)
#' }
#' @export


speech_check <- function(tidy_speech, initial, expand = FALSE){

        tidy_speech$legislator <- as.character(tidy_speech$legislator)
        out <- tidy_speech %>%
                transform('init' = toupper(substring(.$legislator, 1, 1))) %>%
                dplyr::select('legislator', 'legislature', 'init') %>%
                dplyr::distinct() %>%
                as.data.frame() %>%
                dplyr::arrange(.$legislator) %>%
                base::split(., .$init)

        if(expand){

                out <- lapply(out, "[", -3)

        } else {

                out <- out %>%
                        lapply(., "[", 1) %>%
                        lapply(., dplyr::distinct)

        }

        for(i in 1:length(out)){
                rownames(out[[i]]) <- NULL
        }

        if(!missing(initial)){

                initial <- toupper(initial)
                return(out[initial])

        } else {

                return(out)
        }
}


















