#' @title Rename legislators
#' @description allows to adjust the name of the legislators prior to compiling the data.
#' @param tidy_speech tibble class \code{puy}.
#' @param old old name legislator.
#' @param new new name legislator.
#' @param id id 'floorspeech'.
#' @return data.frame.
#' @examples
#' \dontrun{
#' speech_check(out2, "A")
#' out <- speech_legis_replace(out, old = "ABADALA",  new = "ABDALA")
#' }
#'
#' @export

speech_legis_replace <- function(tidy_speech, old, new, id = NULL){

    if(!inherits(tidy_speech, "puy")){stop("Input is not of class 'puy'.", call. = FALSE)}
    if(!is.null(id)){
        tidy_speech[tidy_speech$legislator == old & tidy_speech$id == id, "legislator"] <- new
    }else{
        tidy_speech[tidy_speech$legislator == old, "legislator"] <- new
        }
    return(tidy_speech)
}










