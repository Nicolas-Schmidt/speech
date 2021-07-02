#' @title Number of words
#' @description Word count.
#' @param string character of length equal to or greater than one.
#' @param rm.name by default is \code{FALSE}. Remove word 'SENOR' and name of legislator.
#' @param exclude words that are to be excluded from counting.
#' @param min.char integer that determines the words that have less than a
#'     certain number of characters.
#' @param rm.long integer that determines the number of characters from which
#'     words have to be deleted from the count.
#' @param replace.punct by default is "".
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
#'
#' \donttest{
#' url <- "http://bit.ly/35AUVF4"
#' out <- speech_build(file = url, compiler = TRUE)
#' out$word <- speech_word_count(out$speech, rm.name = TRUE)
#' out$word2 <- speech_word_count(out$speech)
#' }
#' @export


speech_word_count <- function(string, rm.name = FALSE, exclude = NULL, min.char = 0L, rm.long = Inf,
                              rm.num = FALSE, replace.punct = ""){

    s_name <- string
    string[is.na(string)] <- ""
    string <- string %>%
        gsub(pattern = "\n|\t", replacement = " ", x = .) %>%
        gsub(pattern = "[[:punct:]]", replacement = replace.punct, x = .)

    if(rm.num){
        string <- stringr::str_remove_all(string,pattern = "\\d")
    }
    string <-
        string %>%
        strsplit(., split = " ") %>%
        purrr::map_int(., function(x){
            tibble::enframe(x, name = NULL) %>%
                dplyr::mutate('char' = nchar('value')) %>%
                dplyr::filter('char' > min.char, 'char' < rm.long, !('value' %in% exclude)) %>%
                nrow()}) %>%
        ifelse(.== 0L, NA_integer_, .)

    if(rm.name){
        n <- stringr::str_count(s_name, "SE\u00d1OR ")
        name <- sapply(strsplit(stringr::str_extract(s_name, pattern = "[[A-Z\u00d1 ]{2,}]+([A-Z ]+\\. |\\s)"), " "), length) - 1
        m <- n + (n*name)
        string <- string - m
    }
    string
}


