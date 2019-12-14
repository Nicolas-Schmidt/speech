#' @title Speech recompiler
#' @description It allows to recompile an object of the \code{puy} class, the datasets
#'     speech or a data.frame built with \code{speech_build} to which the
#'     variable political party was added.
#' @param tidy_speech data.frame.
#' @param compiler_by character vector. Variables for which you may want to recompile the data frame.
#' @return data.frame.
#' @details The default compilation is that of \ code {speech_build (., compiler = TRUE}).
#'     This function allows to recompile the data by different levels of aggregation:
#'     chamber, legislature or other variables.
#' @examples
#' \dontrun{
#' dat <- data(speech)
#' speech_recompiler(dat)
#' speech_recompiler(dat)
#' }
#' @export

speech_recompiler <- function(tidy_speech,
                              compiler_by = c("legislator", "party", "legislature", "chamber")){
    compiler(tidy_speech = tidy_speech, compiler_by = compiler_by)
}


