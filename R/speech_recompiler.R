#' @title Speech recompiler
#' @description It allows to recompile an object of the \code{puy} class, the datasets
#'     speech or a data.frame built with \code{speech_build} to which the
#'     variable political party was added.
#' @param tidy_speech tibble.
#' @param compiler_by character vector. Variables for which you want to recompile.
#' @return tibble.
#' @details The default compilation is that of \ code {speech_build (dat, compiler = TRUE}).
#'     This function allows you to recompile the data by different levels of aggregation:
#'     chamber only, only legislature or other opacities.
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


