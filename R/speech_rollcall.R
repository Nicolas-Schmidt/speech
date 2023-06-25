#' @title Detects roll-call
#' @description Detects roll-call in floor speeches and converts them to a dataset.
#' @param file list or character vector specifying the path or URL to a PDF file.
#'     It can be one or more files.
#' @param add.error.sir character vector. It allows to specify different ways in which
#'     the term that orders the speeches could be miswritten: sir. By default it is \code{NULL}.
#' @param rm.error.leg character vector. It allows to add legislator's names
#'     to be eliminated. By default it is \code{NULL}.
#'     By default, "PRESIDENTE", "SECRETARIO", "SUBSECRETARIO", and "MINISTRO" are eliminated.
#' @details This function detects roll-call votes on floor speeches. It only detects votes
#'     where the vote can be affirmative or negative. This leaves out a set of roll-call
#'     votes, such as those for the allocation of positions in the chamber.
#' @return data.frame with the following variables:
#'      \itemize{
#'             \item{\code{legislator}: Name of the legislator}
#'             \item{\code{vote}: Voting, 1 = affirmative, 0 = Negative}
#'             \item{\code{argument}:If the legislator justifies the vote, it is worth 1, otherwise 0.}
#'             \item{\code{speech}: Speech}
#'             \item{\code{chamber}: Chamber}
#'             \item{\code{date}: Date}
#'             \item{\code{legislature}: Legislature}
#'             \item{\code{rollcall}: Number of roll-call in session}
#'             \item{\code{id}: Id}
#'             \item{\code{sex}: Sex of legislator}
#'            }
#' @examples
#' \donttest{
#' # url <- speech::speech_url(chamber = "D", from = "14-04-2004", to = "14-04-2004")
#' # out <- speech_rollcall(file = url)
#' # summary(out)
#' }
#' @export


speech_rollcall <- function(file, add.error.sir = NULL, rm.error.leg = NULL){

        out <-
                sfile(file) %>%
                purrr::map(speech.pow,
                           add.error.sir = add.error.sir,
                           rm.error.leg = rm.error.leg,
                           quality = FALSE,
                           nominate = TRUE
                )

        out <- out[!unlist(lapply(out, is.null))]
        out <- out[purrr::map_int(out, nrow) != 0]

        out2 <- list()
        for(i in 1: length(out)){
            out2[[i]] <- speech_pow_rc(out[[i]])
        }
        out <- do.call('rbind', out2)
        out$speech <- stringr::str_squish(out$speech)
        invisible(add_sex(clean_t(out)))
}


#' @title summary.nominal
#' @description Returns a summary of a rollcall vote object.
#' @param object an object of class \code{nominal}, the output of \code{\link{speech_rollcall}}.
#' @param ... additional parameter.
#' @return data.frame with the following variables:
#'      \itemize{
#'             \item{\code{Chamber}: Chamber}
#'             \item{\code{Date}: Date}
#'             \item{\code{Legislators}: Number of legislators in the voting}
#'             \item{\code{Affirmative}: Number of affirmative votes}
#'             \item{\code{Negative}: Number of negative votes}
#'             \item{\code{prop_AF}: Proportion of affirmative votes}
#'             \item{\code{prop_NG}: Proportion of negative votes}
#'             \item{\code{prop_women}: Proportion of women in the voting}
#'             \item{\code{prop_arg}: Proportion of legislators justifying the vote}
#'             \item{\code{rc}: Number of roll-call in session}
#'            }
#' @rdname speech_rollcall
#' @export
#'

summary.nominal <- function(object, ...){
    table_rollcall_vote(object)
}




