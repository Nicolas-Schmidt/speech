#' @title Speech uncompiler
#' @description It allows to undo the compilation of a floor speech.
#' @param tidy_speech data.
#' @return data.frame.
#' @examples
#' \donttest{
#' # url <- "http://bit.ly/35AUVF4"
#' # out <- speech_build(file = url, compiler = TRUE)
#' # out2 <- speech_uncompiler(out)
#' }
#' @export


speech_uncompiler <- function(tidy_speech){

    unc <- uncompiler(data = tidy_speech)
    r <- tibble::tibble(do.call("rbind", unc))
    r$speech <- stringr::str_squish(r$speech)
    invisible(r)
}
