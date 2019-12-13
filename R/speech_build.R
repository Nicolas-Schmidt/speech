#' @title Transform speeches in pdf to data.frame
#' @description It allows to extract the individual interventions of each legislator
#'     in document and obtain a data.frame with all the interventions of each legislator
#'     in a session of the congress.
#' @param file list or character vector specifying the path or URL to a PDF file.
#'     It can be one or more than one file.
#' @param add.error.sir character vector. It allows to add errors on how
#'     the word that orders the speeches is written: sir. By default it is \code{NULL}.
#' @param rm.error.leg character vector. It allows adding names of
#'     legislators to be eliminated. By default it is \code{NULL}.
#'     By default, "PRESIDENTE", "SECRETARIO", "SUBSECRETARIO", and "MINISTRO" are eliminated.
#' @param compiler logical. When finalizing the agreements of the speeches
#'     it is necessary to choose to compile. To compile implies to unite all the
#'     speeches of each of the legislators for each document. As it is an operation
#'     that must be carried out after making corrections, it is necessary to opt for it.
#'     By default it is \code{FALSE}.
#' @param quality logical. If \code{TRUE}, two quality indicators are added about
#'     the construction process of the data.frame according to the quality of the document.
#'     \itemize{
#'             \item{index_1: Proportion of the text recovered in function
#'             of the theoretical text (\code{param = list(char = 6500, drop.page = 2)})
#'             that must have the docuemnto.}
#'             \item{index_2: Proportion of the final text as a function of the
#'             recovered text. It is the proportion of the document in which there are
#'             only interventions by legislators.}
#'            }
#' @param param list of length 2 giving the character for page and drop page non evaluate
#'     respectively. The default values are the median characteristics of
#'     8500 documents that make up the speech datasets.
#' @details This function converts PDF documents to data.frame. This conversion is
#'     made by seeking interventions of legislators from the word "SENOR". As the
#'     quality of PDF files is not always the best it is recommended to verify that
#'     no legislator is omitted in the data.frame construction process. To make
#'     corrections of the word "SENOR" is that the argument \code{add.error.sir}
#'     should be used. The function has a long list of different ways in which
#'     the word "SENOR" may be written in a document, but not all possible future
#'     problems are covered. When the PDF document is a scan that was submitted to
#'     an OCR, it is possible that it should be checked with greater precision
#'     that the operation is performed correctly.
#' @return tibble class \code{puy} with the following variables:
#'      \itemize{
#'             \item{\code{legislator}: name of the legislators}
#'             \item{\code{speech}: speeches by legislators}
#'             \item{\code{date}: session date}
#'             \item{\code{id}: name \code{file}}
#'             \item{\code{legislature}: number of the legislature (period of government)}
#'             \item{\code{chamber}: chamber to which the document belongs.
#'             It can be: Deputy, Senator, General Assembly or Permanent Commission.}
#'            }
#'          If quality is TRUE, the following are added:
#'      \itemize{
#'             \item{\code{index_1}: index_1}
#'             \item{\code{index_2}: index_2}
#'            }
#' @examples
#' \dontrun{
#'
#' out <- list.files(pattern = "*.pdf") %>% speech_build()
#'
#' out <- list.files(pattern = "*.pdf") %>%
#'     speech_build(., compiler = TRUE, param = list(char = 4500, drop.page = 3))
#'
#' url <- "https://legislativo.parlamento.gub.uy/temporales/20180621s0017517818.pdf"
#' out <- speech_build(file = url)
#'
#' urlS <- c("https://legislativo.parlamento.gub.uy/temporales/20191710s0002622525.pdf",
#'           "https://legislativo.parlamento.gub.uy/temporales/20190917c00019885716.pdf")
#' out <- speech_build(file = urlS)
#'
#' out <- speech_build(file = url, compiler = FALSE,
#'                      quality = TRUE,
#'                      add.error.sor = c("SEf'IOR"),
#'                      rm.error.leg = c("PRtSIDENTE", "SUB", "PRfSlENTE"),
#'                      param = list(char = 6000, drop.page = 3))
#' }
#'
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
        out <- dplyr::bind_rows(out)
        out$speech <- stringr::str_squish(out$speech)

        if(compiler){
            compiler(tidy_speech = out,
                     compiler_by = c("legislator", "legislature", "chamber", "date", "id"))
        }else{
            invisible(out)
        }
}



