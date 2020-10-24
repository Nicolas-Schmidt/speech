
#' @title Rename legislators
#' @description allows to modify the legislators' name prior to compiling the data.
#' @param tidy_speech data.frame class \code{puy}.
#' @param old old legislator's name.
#' @param new new legislator's name.
#' @param id id 'floor speech'.
#' @return data.frame.
#' @examples
#' \donttest{
#' url <- "http://bit.ly/35AUVF4"
#' out <- speech_build(file = url)
#' speech_check(out, "G")
#' out <- speech_legis_replace(out, old = "GOI",  new = "GONI")
#' }
#'
#' @export

speech_legis_replace <- function(tidy_speech, old, new, id = NULL){

    if(!inherits(tidy_speech, "puy")){

        stop("Input is not of class 'puy'.", call. = FALSE)

    }

    if(!is.null(id)){

        tidy_speech[tidy_speech$legislator == old & tidy_speech$id == id, "legislator"] <- new

    } else {

        tidy_speech[tidy_speech$legislator == old, "legislator"] <- new

    }

    return(tidy_speech)
}



