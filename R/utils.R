#' @importFrom magrittr %>%
#' @importFrom lubridate %within% ymd
#' @importFrom pdftools pdf_text
#' @importFrom dplyr summarise ungroup group_by n select
#' @importFrom purrr map

v <- c('rollcall',
       'vote',
       'Legislators',
       'Affirmative',
       'prop_AF',
       'sex',
       'argument',
       'Date',
       'Negative',
       'prop_NG',
       'prop_women',
       'prop_arg',
       'rc',
       'Chamber',
       'chamber')



if(getRversion() >= "2.15.1"){
    utils::globalVariables(c('.', v))
    utils::suppressForeignCheck(c('.', v))
}

legislature <- function(df, name_var_date){

    legislaturas$interval <- lubridate::interval(legislaturas$fecha_inicio, legislaturas$fecha_fin)
    df  <- as.data.frame(df)
    f   <- df[, names(df) == name_var_date]
    f2  <- numeric(nrow(df))
    for(i in 1:length(f2)){
        w <- which(f[i] %within% legislaturas$interval)
        f2[i] <-ifelse(is.numeric(w), w, NA)
    }
    as.integer(f2)
}

aux <- function(object){
        if(object == "esir"){

                object <- paste(c("SEJ\u00d1OR",
                                  "8E\u00d1OR",
                                  "~E~WR",
                                  "SE~OR",
                                  "S~OR",
                                  "SEROR",
                                  "SMOR",
                                  "SE:ROR",
                                  "SEJ.'ilOR",
                                  "SElilOR",
                                  "SEJ'ilOR",
                                  "SEl'ilOR",
                                  "SE:\u00d1OR",
                                  "SEJ\u00d1OR",
                                  "S\u00d1~OR",
                                  "S@OR",
                                  "SE:l'tOR",
                                  "SEJS'OR",
                                  "SUOB",
                                  "SENOR",
                                  "SE:f.tOR",
                                  "SEI'\u00ed\"OR",
                                  "SEJ.~OR",
                                  "SEI'lOR",
                                  "SJ.~OR",
                                  "SEl~OR",
                                  "SE'\u00d1OR",
                                  "SE~JOR",
                                  "SEf~OR",
                                  "SEtlOR",
                                  "SEf.JOR",
                                  "SEfjO\u00edl",
                                  "SEfJOR",
                                  "SEl\\IOR",
                                  "SEtilOR",
                                  "SEl\\\\IOR",
                                  "SEl\\\\JOR",
                                  "SEl'JOR",
                                  "DiSE\u00d1OR",
                                  "SEfilOR",
                                  "Sel'ior",
                                  "SEi\\\\.IOR",
                                  "SEi\\\\JOR",
                                  "SEl\"JOR",
                                  "SEJli.lOR",
                                  "SE\"'OR",
                                  "SEJ\\\\IOR",
                                  "SEt\\\\i\u00f3R",
                                  "SEl\'.IOR",
                                  "SEIQOR",
                                  "SEl\'IOR",
                                  "SEt\\IOR",
                                  "SEl'i.IOR",
                                  "SEl'JOR",
                                  "SEI'JOR",
                                  "SEJ\\)j'OR",
                                  "SEf'IOR",
                                  "SEJ\\\\.IOR",
                                  "SEt:JOR",
                                  "SEl\"ilOR",
                                  "SEl\"IOR",
                                  "SE\\!\\\\JOR",
                                  "SE!ilCF",
                                  "SEf;IOR",
                                  "SEISIOR",
                                  "Sl;\u00d1OR",
                                  "SEAOR",
                                  "SEf.ilOR",
                                  "SE1'10R",
                                  "SEFIDR",
                                  "SEt\\\\IOR",
                                  "SEt\\\\10",
                                  "SEf.IOR",
                                  "SEl'iJOR",
                                  "SEf:.IOR",
                                  "SEJ\\\\JOR",
                                  "SEf110R",
                                  "SEl\\\\IQR",
                                  "SEl\\\\.IOR",
                                  "SErilOR",
                                  "SE\u00d1.OR",
                                  "SE!'JOR",
                                  "SEl'\u00ed\\!OA",
                                  "SEici\\!OR",
                                  "SEl\"lOR",
                                  "SEi\\\\lOR",
                                  "SEl\\\\jOR",
                                  "SERcR",
                                  "SEF40R",
                                  "seiQOR",
                                  "SEtl:IOR",
                                  "SEl\\\\iOR",
                                  "SEf'IOR",
                                  "SEli\u00edOR",
                                  "SEKIOR",
                                  "SEf;IQR",
                                  "SE;tilOR",
                                  "SEl'\\\\JOR",
                                  "SEl'iilOR",
                                  "SE\"10R",
                                  "SEJli.IOR",
                                  "SEf;iOR",
                                  "SEOOR",
                                  "sElilOR",
                                  "SEF:IOR",
                                  "~OR",
                                  "SE~CR",
                                  "S~OO",
                                  "SEfJOO",
                                  "SEFJOR",
                                  "5ERCR",
                                  "Se:F:lOR",
                                  "SERCR",
                                  "SEfilCR",
                                  "SERDR",
                                  "SEACR",
                                  "SElilCR",
                                  "SERQR",
                                  "sEROR",
                                  "SEFIOR",
                                  "soberSa:lCR",
                                  "SEfi\\!CR",
                                  "SER00",
                                  "SE\u00d1OO",
                                  "SERcF",
                                  "SERoR",
                                  "SEfilOO",
                                  "SEFICR",
                                  "srnCR",
                                  "SEFICR",
                                  "SEFICR",
                                  "SEfiIDR",
                                  "SE\u00d1CR",
                                  "srnOR",
                                  "SEFlOR",
                                  "SEf;\u00edOR",
                                  "SEFlOR",
                                  "SEf:loR",
                                  "SEru:R",
                                  "SERt:R",
                                  "SEl'\\!CR",
                                  "SEf:\u00edCR",
                                  "SEFKR",
                                  "sERCR",
                                  "Srnffi",
                                  "SEF\\!ffi",
                                  "SElllOR",
                                  "SERclR",
                                  "SElllCR",
                                  "SEl'lOR",
                                  "SEfilffi",
                                  "SER~",
                                  "SEF'.lffi",
                                  "SENDR",
                                  "~ENOR",
                                  "SEfKJR",
                                  "SHIOR",
                                  "SEf.\u00edOR",
                                  "SEf:ICJf",
                                  "SEflOR",
                                  "SEr:.no",
                                  "SEFillR",
                                  "SEf:ICR",
                                  "Sf\u00d1OR",
                                  "s~rn",
                                  "SEfiicF",
                                  "SE\u00d1ffi",
                                  "SEli\u00edrn",
                                  "SEfiiOR",
                                  "SEf:lrn",
                                  "SEli\u00edCR",
                                  "SEli\u00edCR",
                                  "SEf;lffi",
                                  "sEFJOR",
                                  "SEFlCR",
                                  "SEli\u00edCF",
                                  "SEf:lOR",
                                  "SER0R",
                                  "SE\u00d1CJ",
                                  "SEF30R",
                                  "SEfllOR",
                                  "SEFJCIR",
                                  "SEf'lff",
                                  "SElilc:R",
                                  "SEf.lCR",
                                  "SEf.1CR",
                                  "SEf'.lOR",
                                  "SE\u00edlOR",
                                  "srnoR",
                                  "SEf.ioR",
                                  "SE\\!ilOR",
                                  "SEF4QR",
                                  "SERffi",
                                  "~ FREY",
                                  "SEb",
                                  "SEfIDR",
                                  "SeF\u00edor",
                                  "SEl\\\\lOR",
                                  "SE\u00d1\u00faR",
                                  "SEf\u00edOR",
                                  "SE\u00d1LA",
                                  "SEROO",
                                  "SEFJDR",
                                  "SEFat",
                                  "SEfiKJR",
                                  "SE\\(i:l\\(\\]R",
                                  "SEf;\\(\\)R",
                                  "SE\\!irJR",
                                  "SEliiOR",
                                  "SEf.lOR",
                                  "StFlOR",
                                  "St~",
                                  "SEIQOA",
                                  "SEFloR",
                                  "SEROFI",
                                  "SEFaelR",
                                  "S\\[SE\u00d1OR",
                                  "~Ef'.JOR",
                                  "SrnDR",
                                  "SEJ!itOR",
                                  "SE:&OR",
                                  "SI!;\u00d1OR",
                                  "SE:\u00d1'OR",
                                  "SE\u00edi\u00ed\"OR",
                                  "SE1il'OR",
                                  "SEiil'OR",
                                  "SEl'll\"OR",
                                  "SDOR",
                                  "SElil'OR",
                                  "SE:f\u00edrOR",
                                  "SEilOR",
                                  "SEJI:lOR",
                                  "SE:f.iOR",
                                  "SEI'l'OR",
                                  "SEI\\\\fOR",
                                  "SimOR",
                                  "SE:filOR",
                                  "SEl\\\\!OR",
                                  "SE'lllOR",
                                  "SEJ:ItOR",
                                  "SEl'tOR", "SElliOR",
                                  "8!:-..\u00d1OR",
                                  "SE:l.ll'OR",
                                  "SEfiOR",
                                  "SE'fi'tOR",
                                  "SE&OR",
                                  "SEl'i:lOR",
                                  "SE:r::tOR",
                                  "SEl'\u00ed'OR",
                                  "SEiitOR",
                                  "SE:AOR",
                                  "SEftOR",
                                  "SE:FJOR",
                                  "SE1i\u00edOR",
                                  "SE:fil\"OR",
                                  "SE:fil'OR",
                                  "SmOR",
                                  "SF\u00d1OR",
                                  "S:EaOR",
                                  "tSE\u00d1OR",
                                  "SEl'\u00edOR",
                                  "SE1iiOR",
                                  "SFmOR",
                                  "SE\u00ediJOR",
                                  "SE1tOR",
                                  "SE:\u00d1OR",
                                  "SERo:a",
                                  "SE:flrOR",
                                  "SE:IilOR",
                                  "SEA'OR","SE~",
                                  ",SE:&OR",
                                  "SE\"&OR",
                                  "SE:fiOR",
                                  "SEI'tOR",
                                  "SE'&OR",
                                  "SElitOR",
                                  "s~oR",
                                  "SE.fjOR",
                                  "SE::lQ'OR",
                                  "SdOR",
                                  "S~",
                                  "SE:ftOR",
                                  "SEI'!OR",
                                  "SEI'IOR",
                                  "smoR",
                                  "SE&QR",
                                  "SE\u00d1QR",
                                  "SE:\u00edi\u00ed'OR",
                                  "SEt\\\u00edOR",
                                  "SI \u00d1OR",
                                  "SE \u00d1OR",
                                  #"ÑOR",
                                  "\u00d1OR"
                                  ),
                                collapse = "|")

        }

        if(object == "meses"){

                object <- paste(c("ENERO",
                                  "FEBRERO",
                                  "MARZO",
                                  "ABRIL",
                                  "MAYO",
                                  "JUNIO",
                                  "JULIO",
                                  "AGOSTO",
                                  "SETIEMBRE",
                                  "OCTUBRE",
                                  "NOVIEMBRE",
                                  "DICIEMBRE",
                                  "SEPTIEMBRE",
                                  "ENER",
                                  "FEBR"),
                                collapse = "|")

        }
        if(object == "eleg"){

                object <- "^(PRES|PESI|ESIDEN|SIDENTE|RESIDENT|SENAD|REPRE|SECRE|MINIS|LEGIS|PROSE|SUBSEC|DIPUTAD"

        }

        if(object == "chamb"){

                object <- c("ASAMBLEA GENERAL",
                            "CAMARA DE SENADORES",
                            "CAMARA DE REPRESENTANTES",
                            "COMISION PERMANENTE",
                            "GENERAL", "SENADORES",
                            "REPRESENTANTES",
                            "PERMANENTE")

        }

        object
}


prospow <- function(file, add.error.sir = NULL){

        esir <- aux("esir")
        if(!is.null(add.error.sir)){
            esir <- paste0(esir, "|", paste0(add.error.sir, collapse = "|"), collapse = "")
        }
        text0 <- pdfSIR(file)
        text  <- preComp(text0[["text"]], esir = esir)
        text1 <- text0[[1]]
        list(text, text1)
}


speech.pow <- function(file, add.error.sir = NULL, rm.error.leg = NULL, compiler = FALSE,
                       quality = FALSE, param = list(char = 6500, drop.page = 2), nominate = FALSE){

        esir <- aux("esir")

        if(!is.null(add.error.sir)){
                esir <- paste0(esir, "|", paste0(add.error.sir, collapse = "|"), collapse = "")
        }
        text0 <- pdfSIR(file)
        text  <- preComp(text0[["text"]], esir = esir)
        text1 <- text0[[1]]

        clave <- stringr::str_which(text, "^SE\u00d1OR")
        clave <- clave[clave > 300]
        ident <- sub("([^.]+)\\.[[:alnum:]]+$", "\\1", basename(file))

        if(length(clave) <= 1){
                warning(paste("The document", ident,"does not contain interventions by legislators or it is not possible to recognize them in the text. \n"), call. = FALSE)
        }else{
                clave <- c(clave, length(text))
                vec_speech <- character(length(clave)-1)
                for(i in 1:(length(clave)-1)){
                        vec_speech[i] <- paste(text[clave[i]:(clave[i+1]-1)], collapse = " ")
                }
                ## legis name --------------------------------------------------

                vec_speech2 <- chartr('\u00e1\u00e9\u00ed\u00f3\u00fa','aeiou', vec_speech)
                legis <- substring(vec_speech2, 1, regexpr("[a-z]|[A-Z]+\\s+[a-z]", vec_speech2) -2) %>%
                        stringr::str_remove_all(pattern = "(SE\u00d1ORES|SE\u00d1ORA|SE\u00d1OR)")

                #empt <- setdiff(1:length(legis), stringr::str_which(legis, "[:alnum:]"))
                empt <- which(nchar(legis) <= 2)
                if(length(empt)!=0){
                        for(i in 1:length(empt)){
                                legis[empt[i]] <- substring(vec_speech[empt[i]], 1, 20)
                        }
                }
                legis <- legis %>%
                        stringr::str_remove_all(pattern = "(SE\u00d1ORES|SE\u00d1ORA|SE\u00d1OR)") %>%
                        stringr::str_remove_all(pattern = "[^[:alnum:][:blank:]?/\\:-]") %>%
                        stringr::str_remove_all(pattern = "[^A-z\u00d1\u00F1. ]") %>%  ### check A-Z or A-z
                        stringr::str_squish()

                ## date --------------------------------------------------------
                meses <- aux("meses")
                fe <- stringr::str_which(toupper(text1), pattern = meses)
                if(length(fe) != 0){
                        suppressWarnings(
                                fdiario <- c(text1[fe[1]-2], text1[fe[1]], substring(text1[fe[1]+2], 1, 4)) %>%
                                        paste(., collapse = " ") %>%
                                        stringr::str_squish()%>%
                                        lubridate::parse_date_time(order = "dmy")
                        )
                        fdiario <- as.Date(fdiario)
                }else{
                        fdiario <- NA
                }
                ## chamber -----------------------------------------------------

                chamb <- aux("chamb")
                cha <- text1 %>% chartr('\u00c1\u00c9\u00cd\u00d3\u00da','AEIOU',.) %>% paste(collapse = " ") %>%
                        gsub(pattern = "  ", replacement = " ", .)

                cha <- chamb[stringr::str_which(cha, chamb)[1]] %>% chamber_fit()

                ## legislature -------------------------------------------------

                text2 <- tibble::tibble(
                        legislator = chartr('\u00c1\u00c9\u00cd\u00d3\u00da','AEIOU', legis),
                        speech = vec_speech,
                        chamber = cha,
                        date = fdiario
                )
                if(!is.na(fdiario)){
                        text2$legislature <- legislature(text2, name_var_date = "date")
                }else{
                        text2$legislature <- NA_integer_
                }
                text2$id <- ident
                eleg <- aux("eleg")
                if(!is.null(rm.error.leg)){
                        eleg <- paste0(eleg, "|", paste0(rm.error.leg, collapse = "|"), ")")
                }else{
                        eleg <- paste0(eleg, ")")
                }

                ## rollcall ----------------------------------------------------

                if(!nominate){
                    text2 <- text2[-c(stringr::str_which(toupper(text2$legislator), toupper(eleg))),]
                }

                text2 <- text2[nchar(text2$legislator) < 25 ,] # nombres muy largos
                text2 <- text2[stringr::str_detect(text2$speech, "[a-z]"),]

                if(nrow(text2)==0L){
                        warning(paste("The document", ident,"only contains interventions by the president. \n"), call. = FALSE)
                }

                ## class for compiler ---------------------------------

                rmhead <- header(file = file)
                text2$speech <- stringr::str_replace_all(text2$speech, "\\s{2,}", " ")
                for(i in seq_along(rmhead)){text2$speech <- gsub(x = text2$speech, pattern = rmhead[i], replacement = "", fixed = TRUE)}

                if(quality){
                        if(nrow(text2) != 0L){
                                n1 <- sum(nchar(text)) + length(text)
                                index_1 <- (param$char * (length(rmhead) - param$drop.page))/n1
                                index_2 <- sum(nchar(text2$speech))/n1
                                text2$index_1 <- round(index_1, 2)
                                text2$index_2 <- round(index_2, 2)
                        }
                }
                text2 <- text2 %>% dplyr::filter('legislator' != "")
                text2$speech <- stringr::str_replace(text2$speech, "\\.", "\\. ")
                class(text2) <- c(attributes(text2)$class, "puy")
                return(text2)
        }
}



compiler <- function(tidy_speech, compiler_by = character()){

    vars <- match(compiler_by, names(tidy_speech))

    if(length(vars) == 0L){
        stop("The variables of 'tidy speech' do not match those of 'compiler_by'", call. = FALSE)
    }

    if(length(vars) != length(compiler_by)){
        warning("Not all the variables of 'compiler_by' are in 'tidy speech'", call. = FALSE)
    }

    war <- sapply(tidy_speech[, compiler_by], FUN = function(x){any(is.na(x))})
    war <- names(war)[war == TRUE]

    if(length(war) > 0){
        warning(paste("Variables that are in 'compiler_by' contain NA values:", paste(war, collapse = ", ")), call. = FALSE)
    }
    vars <- compiler_by[!compiler_by %in% war] #:-->*

    tidy_speech$rec <- apply(tidy_speech[,vars], 1, paste, collapse = "__") #:-->*
    ts_out <- tidy_speech %>% base::split(.$rec)
    cby <- tibble::tibble('varid' = names(ts_out))
    out <- ts_out %>%
        purrr::map(.,function(x){
            tibble::tibble(speech = paste(x$speech,  collapse = " "))
        }) %>%
        dplyr::bind_rows() %>%
        dplyr::bind_cols(cby,.) %>%
        tidyr::separate('varid', into = vars, sep = "__")##

    if("legislature" %in% vars){ #:-->*
        out$legislature <- as.integer(out$legislature)
    }

    if("date" %in% vars){ #:-->*
        if(is.character(tidy_speech$date)){out$date <- NA}
        out$date <- as.Date(out$date)
    }

    if(length(war) > 0){ #:-->*
        for(i in 1:length(war)){out[, war[i]] <- NA} #:-->*
        out <- out[, c(compiler_by, "speech")] #:-->*
        }

    if("index_1" %in% names(tidy_speech)){
        out$index_1 <- unique(tidy_speech$index_1)
        out$index_2 <- unique(tidy_speech$index_2)
    }

    class(out) <- c(attributes(out)$class, "puy")

    invisible(
              SError(
                      add_sex(  # problem in flow with replace
                              clean_t(
                                      out))))

}

chamber_fit <- function(chamber){

        problem <- aux("chamb")[5:8]
        correct <- aux("chamb")[1:4]
        ubic <- which(problem %in% chamber)
        chamber <- ifelse(length(ubic) > 0, correct[ubic], chamber)
        if(is.logical(chamber)){chamber <- NA}
        return(chamber)

}

header <- function(file){

    fdoc <- tm::readPDF("pdftools")
    fdoc <- fdoc(elem = list(uri = file), language = "spanish")$content
    fdoc <- fdoc %>%
        strsplit(., split = "\\r") %>%
        lapply(., "[", 1) %>%
        stringr::str_replace_all(pattern = "\\s{2,}", replacement = " ") %>%
        stringr::str_replace_all(pattern = "- ", replacement = "") %>%
        stringr::str_replace_all(pattern = "-|--|<|>", replacement = "")%>%
        chartr('\u00c1\u00c9\u00cd\u00d3\u00da','AEIOU',.) %>%
        stringr::str_squish() %>%
        .[stats::complete.cases(.)] %>%
        .[nchar(.) > 10]

}

separate_sir <- function(vec){

    detect <- unlist(stringr::str_extract_all(string = vec, pattern = "[[:alnum:][:punct:]]{1,}SE\u00d1OR"))
    if(length(detect) > 0){
        vec_corte <- regexpr("[[:alnum:][:punct:]]SE\u00d1OR", detect)
        for(i in 1:length(detect)){
            vec <- gsub(
                x = vec,
                pattern = detect[i],
                replacement = paste(substr(x = detect[i], start = 1, stop = vec_corte[i]), "SE\u00d1OR"),
                fixed = TRUE
            )
        }
    }
    vec
}


add_sex <- function(data){

    data$sex <- ifelse(stringr::str_detect(data$speech, pattern = "^SE\u00d1ORA"), 0, 1)
    data[stringr::str_which(data$speech, pattern = "SE\u00d1ORALE"), "sex"] <- 1
    data

}


clean_t <- function(x){

    if("legislature" %in% names(x)){
        if(is.na(x$legislature[1])){
            x$legislature <- NA_integer_
        }
    }

    if("chamber" %in% names(x)){
        if(is.na(x$chamber[1])){
            x$chamber <- NA_character_
        }
    }

    if("date" %in% names(x)){
        if(is.na(x$date[1])){
            x$date <- as.Date(x$date)
        }
    }

    if("id" %in% names(x)){
        if(is.na(x$id[1])){
            x$id <- NA_character_
        }
    }

    x$speech <- stringr::str_squish(x$speech)
    x
}


test_date <- function(from, to, legislature){

    legislaturas$interval <- lubridate::interval(legislaturas$fecha_inicio, legislaturas$fecha_fin)
    desde <- which(lubridate::dmy(from) %within% legislaturas$interval)
    hasta <- which(lubridate::dmy(to) %within% legislaturas$interval)
    if(sum(desde, hasta) / 2 == legislature) FALSE else TRUE

}


urlp <- function(step){

    u <- list(
        step1 = "https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion?Cpo_codigo=",
        step2 = "&Lgl_Nro=",
        step3 = "&fecha_desde=",
        step4 = "&fecha_hasta=",
        step5 = "&Ts_diario=&Ssn_Nro=&Tipobusqueda=All&Texto="
    )
    u[[step]]
}


proto_url <- function(chamber, legislature, from, to){  #### hay cambios

    paginas <- as.character(c(0:20))
    url <- purrr::map(paginas,~ paste0(urlp(1),
                                       chamber,
                                       urlp(2),
                                       legislature,
                                       urlp(3),
                                       from,
                                       urlp(4),
                                       to,
                                       urlp(5),"&page=",.)) %>%
        unlist() %>%
        purrr::map(~ .x  %>%
                       rvest::read_html() %>%
                       rvest::html_nodes(".views-field-DS-File-IMG a") %>%
                       rvest::html_attr("href") %>%
                       purrr::map(~ paste0("", .))) %>%
        unlist()
    url
}


parseo <- function(x){

    paste(substring(x, 1, 4), substring(x, 6, 7), substring(x, 9, 10), sep = "-")
}


fechas_legis <- function(from, to){

    periodo <- lubridate::as_date(lubridate::ymd(from):lubridate::ymd(to))
    lista <- list()

    for(i in 1:nrow(legislaturas)){
        lista[[paste(i)]] <- lubridate::as_date(lubridate::ymd(legislaturas$fecha_inicio[i]):lubridate::ymd(legislaturas$fecha_fin[i]))
    }

    dat <- data.frame(
        legis  = rep(1:nrow(legislaturas), lengths(lista)),
        fechas = lubridate::as_date(unlist(lista))
    )

    dat[which(dat$fechas %in% periodo),] %>% split(., f = .$legis) %>% lapply(., function(x) range(x$fechas))
}




urls.out <- function(chamber, from, to){

    param <- fechas_legis(from, to)
    out <- list()
    for(i in 1:length(param)){
        out[[i]] <- proto_url(chamber     = chamber,
                              legislature = names(param)[i],
                              from        = parseo(param[[i]][1]),
                              to          = parseo(param[[i]][2]))
    }
    unlist(out)

}


deepPDF <- function(.x){
    page <- readLines(.x, warn = FALSE)
    on.exit()
    u   <- unlist(strsplit(page[grep("https://infolegislativa.parlamento.gub.uy/temporales", page)], " "))
    url <- stringr::str_remove_all(u[grep(x = u, pattern = "^src")],"\"")
    stringr::str_extract(url, "https://\\S+")

}






uncompiler <- function(data){

    dat <- data
    comp    <- base::split(dat, dat$id)
    diarios <- length(comp)

    unc <- list()
    for(i in 1:diarios){
        ud <- comp[[i]]
        l <- strsplit(ud$speech, "(SE\u00d1OR|SE\u00d1ORA)")
        largo <- lengths(l)
        out <- tibble::tibble(
            legislator  = rep(ud$legislator, largo),
            legislature = unique(ud$legislature)[1],
            chamber     = unique(ud$chamber)[1],
            date        = unique(ud$date)[1],
            id          = unique(ud$id)[1],
            speech      = unlist(l),
            sex         = rep(ud$sex, largo)
        )
        out <- out[nchar(out$speech) >= 2,]
        unc[[i]] <- out
        return(unc)
    }
}

pdfSIR <- function(file){

    fdoc <- tm::readPDF("pdftools")
    fdoc <- fdoc(elem = list(uri = file), language = "spanish")$content
    a    <- strsplit(fdoc, "\n")
    text <- lapply(a, "[", -1)
    text <- text[lengths(text) > 0L]
    list(
        date_cham = unlist(strsplit(a[[1]], " " )),
        text      = text
    )
}

extract_page <- function(text, umbral = ceiling(max(nchar(text))/2)){

    nch  <- nchar(text)
    vec1 <- character()
    vec2 <- character()

    for(i in 1:length(text)){
        if(nch[i] > umbral){
            vec1[i] <- substring(text[i], 1, umbral)
            vec2[i] <- substring(text[i], umbral+1, nch[i])
        } else{
            vec1[i] <- text[i]
            vec2[i] <- "   "
        }
    }

    vec3 <- c(vec1, vec2)
    vec3 <- stringr::str_replace_all(vec3, pattern = "\\s{2,}", " ") %>% stringr::str_squish()
    vec3 <- paste(vec3[nchar(vec3) > 0L], collapse = " ")
    vec3 <- stringr::str_replace_all(vec3, "- ", "")
    vec3 <- stringr::str_replace_all(vec3, "-", "")
    return(vec3)
}

preComp <- function(text, esir){

    out <- unlist(lapply(X = text, FUN = extract_page))
    # out <- stringr::str_replace_all(out, pattern = "[[:punct:]]", replacement = "")
    out <- out %>%
        stringr::str_replace_all(pattern = "\\r\\n|\\r\\t|\\t", replacement = " ") %>%
        stringr::str_replace_all(pattern = "  ", replacement = " ") %>%
        stringr::str_replace_all(pattern = "- ", replacement = "") %>%
        stringr::str_replace_all(pattern = esir, replacement = "SE\u00d1OR") %>%
        stringr::str_replace_all(pattern = ":rlr|&|:&|!it|:\u00a1q'|iQ'", replacement = "\u00d1") %>%
        stringr::str_replace_all(pattern = "-|--|<|>", replacement = "") %>%
        separate_sir() %>%
        strsplit(split = " ") %>%
        unlist() %>%
        chartr('\u00c1\u00c9\u00cd\u00d3\u00da','AEIOU',.) %>%
        stringr::str_squish() %>%
        .[nchar(.) >= 1L]
    out
}




nominal <- function(z){
    stringr::str_detect(string = z, pattern = "Se toma en el siguiente orden")
}


nom_detect <- function(sn){

    nu <- nominal(sn)
    if(sum(nu) != 0){
        which(nu)
    } else{
        stop("No roll-call vote detected.", call. = FALSE)
    }

}



SError <- function(zj){

    zj$speech <- stringr::str_remove_all(string =zj$speech, pattern = "(.SE| SE)")
    ale <- stringr::str_which(zj$speech, pattern = "SE\u00d1ORALE")

    if(length(ale) > 0){
           zj$legislator[ale] <- "SE\u00d1ORALE"
           zj$speech[ale] <- paste("SE\u00d1OR", zj$speech[ale])
           #zj$sex[ale] <- 1
    }
    zj
}

speech_pow_rc <- function(textorc){

    texto <- textorc #### DATA
    nd <- nom_detect(texto$speech)
    nf <- stringr::str_which(
                    string = texto$speech,
                    pattern = "(Dese cuenta del resultado|Han votado)"
                    )

    votaciones <- list()
    for(i in 1:length(nd)){

        votaciones[[i]] <- texto[nd[i]:nf[i],]
        votaciones[[i]]$rollcall <- i
        votaciones[[i]]$vote1 <- NA
        votaciones[[i]]$vote1[stringr::str_detect(votaciones[[i]]$speech, pattern = "(Afirmativ|Por la afirma)")] <- "Afirmativo"
        votaciones[[i]]$vote1[stringr::str_detect(votaciones[[i]]$speech, pattern = "(Negativ|Por la negat)")]   <- "Negativo"
        votaciones[[i]]$vote <- ifelse(votaciones[[i]]$vote1 == "Afirmativo", 1, 0)
        votaciones[[i]] <- votaciones[[i]][-!is.na(votaciones[[i]]$vote1), ]
        votaciones[[i]]$argument <- ifelse(stringr::str_detect(votaciones[[i]]$speech, pattern = "funda"), 1, 0)
        votaciones[[i]] <- votaciones[[i]][,c("legislator",
                                              "vote",
                                              "argument",
                                              "speech",
                                              "chamber",
                                              "date",
                                              "legislature",
                                              "rollcall",
                                              "id")]

    }

    vv <- do.call("rbind", votaciones)
    vv <- assignC(SError(vv))
    return(vv)

}


assignC <- function(.X){
    class(.X) <- c("nominal", class(.X))
    return(.X)
}



cmabSUMM <- function(dd){

    ch <- dd
    chamb <- character()
    for(i in 1:length(ch)){
        if(ch[i] == "ASAMBLEA GENERAL"){chamb[i] <- "AG"}
        if(ch[i] == "CAMARA DE SENADORESL"){chamb[i] <- "CSS"}
        if(ch[i] == "CAMARA DE REPRESENTANTES"){chamb[i] <- "CRR"}
        if(ch[i] == "COMISION PERMANENTE"){chamb[i] <- "CP"}
        if(is.na(ch[i])){chamb[i] <- NA_character_}
    }
    chamb
    #dd$Chamber <- chamb
    #dd <- dd[,c(ncol(dd), 1:(ncol(dd)-1))]

}


table_rollcall_vote <- function(dat){

    foo <-
    dat %>%
    group_by(rollcall, date) %>%
    summarise(Legislators = n(),
              Affirmative = sum(vote),
              Negative   = Legislators - Affirmative,
              prop_AF = round((Affirmative/Legislators)*100, 2),
              prop_NG = round(100-prop_AF,2),
              prop_women = round(((Legislators - sum(sex, na.rm = T))/Legislators)*100,2),
              prop_arg = round((sum(argument)/Legislators)*100,2),
              Date    = unique(date),
              rc = unique(rollcall),
              Chamber = cmabSUMM(chamber)[1]) %>%
    ungroup() %>%
    select(Chamber,
           Date,
           Legislators,
           Affirmative,
           Negative,
           prop_AF,
           prop_NG,
           prop_women,
           prop_arg,
           rc)

    foo

}

c2 <- function(.f){
    class(.f) <- c(class(.f), "surl")
    return(.f)
}

sfile <- function(file){

    if(grepl("^http", file[1])){
        file <- stringr::str_replace(file, pattern = "http:", "https:")
        if(inherits(file, "surl")){
            file <- file
        } else {
            file <- unname(sapply(file, deepPDF))
        }
    }else{
        file <- file
    }
}


### parse id
# If the identifier (id) has more than 20 characters it will be compressed to 20.
# The same if the id is the same for multiple files. In the latter case a new id will
# be generated in the form 'text_01'...'text_n'.






