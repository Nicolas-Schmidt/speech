#' @title Transform speeches in pdf to data.frame
#' @description It allows to extract the individual speeches of each legislator
#'     in a document and obtain a data.frame.
#' @param file list or character vector specifying the path or URL to a PDF file.
#'     It can be one or more files.
#' @param add.error.sir character vector. It allows to specify different ways in which
#'     the term that orders the speeches could be miswritten: sir. By default it is \code{NULL}.
#' @param rm.error.leg character vector. It allows to add legislator's names
#'     to be eliminated. By default it is \code{NULL}.
#'     By default, "PRESIDENTE", "SECRETARIO", "SUBSECRETARIO", and "MINISTRO" are eliminated.
#' @param compiler logical. When the checking of the process of conversion from pdf to data frame
#'     is completed, it is necessary to compile the data frame. To compile implies to unite all the
#'     speeches of each of the legislators for each document. As it is an operation
#'     that must be carried out after making corrections, it is necessary to opt for it.
#'     By default it is \code{FALSE}.
#' @param quality logical. If \code{TRUE}, two quality indicators are added about
#'     the process, according to the quality of the document.
#'     \itemize{
#'             \item{index_1: Proportion of the text recovered according to the original document
#'             (\code{param = list(char = 6500, drop.page = 2)}) that must have the document.}
#'             \item{index_2: Proportion of the final text as a function of the
#'             recovered text. It is the proportion of the document in which there are
#'             only interventions by legislators.}
#'            }
#' @param param list of length 2 with magnitudes for arguments "character for page" and "drop page
#'     non evaluate" respectively. The default values are the median characters of
#'     8500 documents that make up the speech datasets.
#' @details This function converts PDF documents to data.frame. The conversion is
#'     made by seeking interventions of legislators from the word "SENOR". As the
#'     quality of PDF files is not always the best it is recommended to verify that
#'     no legislator is omitted in the data.frame construction process. To make
#'     corrections of the word "SENOR" is that the argument \code{add.error.sir}
#'     should be used. The function has a long list of different ways in which
#'     the word "SENOR" may be written in a document, but not all possible future
#'     problems are covered. When the PDF document is a scan that was treated with
#'     an OCR, it should be checked with greater caution to ensure that the operation
#'     was performed correctly.
#' @return data.frame class \code{puy} with the following variables:
#'      \itemize{
#'             \item{\code{legislator}: name of the legislators}
#'             \item{\code{speech}: speeches by legislators}
#'             \item{\code{date}: session date}
#'             \item{\code{id}: name \code{file}}
#'             \item{\code{legislature}: legislature id (period of government)}
#'             \item{\code{chamber}: chamber to which the document belongs.
#'             It can be: Chamber of Representatives, Senate, General Assembly or Permanent Commission.}
#'            }
#'          If quality is TRUE, the following are added:
#'      \itemize{
#'             \item{\code{index_1}: index_1}
#'             \item{\code{index_2}: index_2}
#'            }
#'
#' @examples
#' \donttest{
#' url <- "http://bit.ly/35AUVF4"
#' out <- speech_build(file = url)
#'
#' out <- speech_build(file = url, compiler = FALSE,
#'                      quality = TRUE,
#'                      add.error.sir = c("SEf'IOR"),
#'                      rm.error.leg = c("PRtSIDENTE", "SUB", "PRfSlENTE"),
#'                      param = list(char = 6000, drop.page = 3))
#'
#' # out <- list.files(pattern = "*.pdf") %>% speech_build()
#'
#' # out <- list.files(pattern = "*.pdf") %>%
#' #     speech_build(., compiler = TRUE, param = list(char = 4500, drop.page = 3))
#' }
#' @export

speech_build <- function(file, add.error.sir = NULL, rm.error.leg = NULL, compiler = FALSE,
                   quality = FALSE, param = list(char = 6500, drop.page = 2)){

        out <- file %>%
                purrr::map(speech.pow,
                           add.error.sir = add.error.sir,
                           rm.error.leg = rm.error.leg,
                           quality = quality,
                           param = list(char = param$char, drop.page = param$drop.page)
                )
        out <- out[!unlist(lapply(out, is.null))]
        out <- out[purrr::map_int(out, nrow) != 0]
        out <- do.call(rbind, out)
        out$speech <- stringr::str_squish(out$speech)
        if(compiler){
            compiler(tidy_speech = out,
                     compiler_by = c("legislator", "legislature", "chamber", "date", "id"))
        }else{
            invisible(out)
        }
}




