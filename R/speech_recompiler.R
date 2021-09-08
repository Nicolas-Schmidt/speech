#' @title Speech recompiler
#' @description It allows to recompile the datasets speech or a data.frame built with
#'     \code{speech_build} to which the variable political party was added.
#' @param tidy_speech data.frame.
#' @param compiler_by character vector. Variables for which you may want to recompile the data frame.
#' @return data.frame.
#' @details The default compilation is that of \ code {speech_build (., compiler = TRUE}).
#'     This function allows to recompile the data by different levels of aggregation:
#'     chamber, legislature or other variables.
#' @examples
#' \donttest{
#' # url <- "http://bit.ly/35AUVF4"
#' # out <- speech_build(file = url)
#' # out2 <- speech_recompiler(out)
#' # out2 <- speech_recompiler(out, compiler_by = c("legislator", "legislature", "chamber"))
#' }
#' @export

speech_recompiler <- function(tidy_speech,
                              compiler_by = c("legislator",
                                              "legislature",
                                              "chamber",
                                              "date",
                                              "id",
                                              "sex")){

    compiler(tidy_speech = tidy_speech, compiler_by = compiler_by)

}


