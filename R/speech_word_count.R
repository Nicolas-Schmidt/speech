#' @title Number of words
#' @description Word count.
#' @param string character of length equal to or greater than one.
#' @param exclude words that are to be excluded from counting.
#' @param min.char integer that determines the words that have less than a
#'     certain number of characters.
#' @param rm.long integer that determines the number of characters from which
#'     words have to be deleted from the count.
#' @param replace.punct logical. If \code{TRUE} punctuation marks within a single
#'      word will be replaced by a space. By default is \code{TRUE}.
#' @param rm.num logical. Indicates whether the numbers in the count will be
#'     eliminated.
#' @return integer.
#' @examples
#' vec <- "Hello world!"
#' speech_word_count(vec)
#'
#' vec2 <- "Hello.world!"
#' speech_word_count(vec2)
#' speech_word_count(vec2, replace.punct = " ")
#'
#' vec3 <- "Hello.world!, HelloHelloHelloHelloHelloHello"
#' speech_word_count(vec3, replace.punct = " ", rm.long = 20)
#'
#' speech_word_count("R version", min.char = 1)
#'
#' r <- "R version 3.5.2 (2018-12-20) -- 'Eggshell Igloo'"
#' speech_word_count(r, rm.num = TRUE)
#'
#' speech_word_count(NA)
#' @export

speech_word_count <- function(string, exclude = NULL, min.char = 0L, rm.long = Inf,
                              rm.num = FALSE, replace.punct = ""){

    string[is.na(string)] <- ""
    string <- string %>%
        gsub(pattern = "\n|\t", replacement = " ", x = .) %>%
        gsub(pattern = "[[:punct:]]", replacement = replace.punct, x = .)

    if(rm.num){string <- stringr::str_remove_all(string,pattern = "\\d")}

    string %>%
    strsplit(., split = " ") %>%
    purrr::map_int(., function(x){
                        tibble::enframe(x, name = NULL) %>%
                        dplyr::mutate('char' = nchar('value')) %>%
                        dplyr::filter('char' > min.char, 'char' < rm.long, !('value' %in% exclude)) %>%
                        nrow()}) %>%
        ifelse(.== 0L, NA_integer_, .)


}





