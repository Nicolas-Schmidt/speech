#' @title View control speech
#' @description Allows to see the legislators' names with problems prior to compiling the data.
#' @param tidy_speech tibble class \code{puy}.
#' @param legis name of the legislator.
#' @param view logical. If \code{TRUE} \code{View} displays datasets containing
#'     legislators' interventions (\code{legis}). By default is \code{FALSE}.
#' @return data.frame.
#' @examples
#' \dontrun{
#' speech_view(tidy_speech = out, legis = c("AMARILLA", "OSTA"), view = FALSE)
#' }
#' @export

speech_view <- function(tidy_speech, legis = character(), view = FALSE){

        if(!inherits(tidy_speech, "puy")){stop("Input is not of class 'puy'.", call. = FALSE)}
        error_legis <- tidy_speech[tidy_speech$legislator %in% legis,]
        if(view) utils::View(error_legis) else print(error_legis, n = Inf)
}







