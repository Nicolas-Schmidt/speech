
## The `speech` package <img src='man/figures/logo.png' align="right" height="180" />

*Nicolás Schmidt, Diego Luján, Juan Andrés Moraes*

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version-ago/speech)](https://cran.r-project.org/package=speech)
[![R build
status](https://github.com/Nicolas-Schmidt/speech/workflows/R-CMD-check/badge.svg)](https://github.com/Nicolas-Schmidt/speech/actions)
[![](https://img.shields.io/badge/devel%20version-0.1.1-blue.svg)](https://github.com/Nicolas-Schmidt/speech)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/speech?color=blue)](https://www.r-pkg.org/pkg/speech)
[![DOI](https://zenodo.org/badge/227908962.svg)](https://zenodo.org/badge/latestdoi/227908962)

<!-- badges: end -->

### Description

Converts the floor speeches of Uruguayan legislators, extracted from the
parliamentary minutes, to tidy data.frame where each observation is the
intervention of a single legislator.

### Installation

``` r
# Install speech from CRAN
install.packages("speech")

# The development version from GitHub:
if (!require("remotes")) install.packages("remotes")
remotes::install_github("Nicolas-Schmidt/speech")
```

### Data generation process

#### 1 - Floor speeches

<img src="man/figures/fspeech.png" style="margin-center:30px;margin-bottom:5px;" width="600" align="center"></a>

#### 2 - Data extraction

<img src="man/figures/fspeechextract.png" style="margin-center:30px;margin-bottom:5px;" width="600" align="center"></a>

#### 3 - First construction of the database: `speech::speech_build()`

<img src="man/figures/fspeechnocompiler.png" style="margin-center:30px;margin-bottom:5px;" width="900" align="center"></a>

#### 4 - Final database: `speech::speech_build(., compiler = TRUE)`

<img src="man/figures/fspeechcompiler.png" style="margin-center:30px;margin-bottom:5px;" width="900" align="center"></a>

### Example

``` r
library(speech)
url <- "https://parlamento.gub.uy/documentosyleyes/documentos/diario-de-sesion/comisionpermanente/6084/IMG/0?width=800&height=600&hl=en_US1&iframe=true&rel=nofollow"
text <- speech::speech_build(file = url)
text
#> # A tibble: 24 x 6
#>    legislator speech              chamber   date       legislature id           
#>    <chr>      <chr>               <chr>     <date>           <dbl> <chr>        
#>  1 BORDABERRY SEÑOR BORDABERRY. ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  2 BORDABERRY SEÑOR BORDABERRY. ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  3 AVIAGA     SEÑORA AVIAGA. Pid~ COMISION~ 2019-09-17          48 0?width=800&~
#>  4 AVIAGA     SEÑORA AVIAGA. En ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  5 GOI        SEÑOR GOÑI. Pido l~ COMISION~ 2019-09-17          48 0?width=800&~
#>  6 GOI        SEÑOR GOÑI. El Fre~ COMISION~ 2019-09-17          48 0?width=800&~
#>  7 MAHIA      SEÑOR MAHIA. Pido ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  8 MAHIA      SEÑOR MAHIA. Graci~ COMISION~ 2019-09-17          48 0?width=800&~
#>  9 ABDALA     SEÑOR ABDALA. Voto~ COMISION~ 2019-09-17          48 0?width=800&~
#> 10 ASTI       SEÑOR ASTI. Obviam~ COMISION~ 2019-09-17          48 0?width=800&~
#> # ... with 14 more rows


speech_check(text, initial = c("A", "M"))
#> $A
#>   legislator
#> 1     ABDALA
#> 2       ASTI
#> 3     AVIAGA
#> 
#> $M
#>   legislator
#> 1      MAHIA
#> 2     MERONI


text <- speech_legis_replace(tidy_speech = text, old = "GOI", new = "GOÑI")
text
#> # A tibble: 24 x 6
#>    legislator speech              chamber   date       legislature id           
#>    <chr>      <chr>               <chr>     <date>           <dbl> <chr>        
#>  1 BORDABERRY SEÑOR BORDABERRY. ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  2 BORDABERRY SEÑOR BORDABERRY. ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  3 AVIAGA     SEÑORA AVIAGA. Pid~ COMISION~ 2019-09-17          48 0?width=800&~
#>  4 AVIAGA     SEÑORA AVIAGA. En ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  5 GOÑI       SEÑOR GOÑI. Pido l~ COMISION~ 2019-09-17          48 0?width=800&~
#>  6 GOÑI       SEÑOR GOÑI. El Fre~ COMISION~ 2019-09-17          48 0?width=800&~
#>  7 MAHIA      SEÑOR MAHIA. Pido ~ COMISION~ 2019-09-17          48 0?width=800&~
#>  8 MAHIA      SEÑOR MAHIA. Graci~ COMISION~ 2019-09-17          48 0?width=800&~
#>  9 ABDALA     SEÑOR ABDALA. Voto~ COMISION~ 2019-09-17          48 0?width=800&~
#> 10 ASTI       SEÑOR ASTI. Obviam~ COMISION~ 2019-09-17          48 0?width=800&~
#> # ... with 14 more rows

text <- speech::speech_build(file = url, compiler = TRUE)
text
#> # A tibble: 11 x 6
#>    legislator legislature chamber    date       id            speech            
#>    <chr>            <dbl> <chr>      <date>     <chr>         <chr>             
#>  1 ABDALA              48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR ABDALA. Vot~
#>  2 ASTI                48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR ASTI. Obvia~
#>  3 AVIAGA              48 COMISION ~ 2019-09-17 0?width=800&~ SEÑORA AVIAGA. Pi~
#>  4 BORDABERRY          48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR BORDABERRY.~
#>  5 GOI                 48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR GOÑI. Pido ~
#>  6 LAZO                48 COMISION ~ 2019-09-17 0?width=800&~ SEÑORA LAZO. Voto~
#>  7 MAHIA               48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR MAHIA. Pido~
#>  8 MERONI              48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR MERONI. Vot~
#>  9 PEREYRA             48 COMISION ~ 2019-09-17 0?width=800&~ SEÑORA PEREYRA. C~
#> 10 TOURNE              48 COMISION ~ 2019-09-17 0?width=800&~ SEÑORA TOURNE. Vo~
#> 11 VIERA               48 COMISION ~ 2019-09-17 0?width=800&~ SEÑOR VIERA. Voto~


text$word <- speech_word_count(text$speech)

dplyr::glimpse(text)
#> Rows: 11
#> Columns: 7
#> $ legislator  <chr> "ABDALA", "ASTI", "AVIAGA", "BORDABERRY", "GOI", "LAZO"...
#> $ legislature <dbl> 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48
#> $ chamber     <chr> "COMISION PERMANENTE", "COMISION PERMANENTE", "COMISION...
#> $ date        <date> 2019-09-17, 2019-09-17, 2019-09-17, 2019-09-17, 2019-0...
#> $ id          <chr> "0?width=800&height=600&hl=en_US1&iframe=true&rel=nofol...
#> $ speech      <chr> "SEÑOR ABDALA. Voto por la señora legisladora Daisy Tou...
#> $ word        <int> 400, 46, 107, 963, 100, 103, 128, 12, 12, 111, 8
```

### Possible application

``` r
library(magrittr)

minchar <- function(string, min = 3){
    string <- stringr::str_remove_all(string, "[[:punct:]]")
    string <- unlist(strsplit(string, " "))
    string[nchar(string) > min]
}

text$speech %>% 
    minchar(., min = 4) %>%  
    quanteda::corpus() %>% 
    quanteda::dfm(remove = c("señor", "señora")) %>% 
    quanteda::textplot_wordcloud(color = rev(RColorBrewer::brewer.pal(10, "RdBu")))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
library(ggplot2)

text$speech %>% 
    minchar(., min = 4) %>%  
    tibble::enframe() %>% 
    tidytext::unnest_tokens(word, value) %>%
    dplyr::count(word, sort = TRUE) %>%
    dplyr::mutate(word = stats::reorder(word, n)) %>%
    dplyr::filter(!stringr::str_detect(word, "^señor")) %>% 
    .[1:40,] %>% 
    ggplot(aes(word, n)) +
        geom_col(col = "black", fill = "#00A08A", width = .7) +
        labs(x = "", y = "") +
        coord_flip() +
        theme_minimal()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="80%" />

#### Citation

To cite package`speech` in publications, please use:

``` r
citation(package = 'speech')
#> Warning in citation(package = "speech"): no date field in DESCRIPTION file of
#> package 'speech'
#> Warning in citation(package = "speech"): could not determine year for 'speech'
#> from package DESCRIPTION file
#> 
#> To cite package 'speech' in publications use:
#> 
#>   Nicolas Schmidt, Diego Lujan and Juan Andres Moraes (NA). speech:
#>   Legislative Speeches. R package version 0.1.1.
#>   https://github.com/Nicolas-Schmidt/speech
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {speech: Legislative Speeches},
#>     author = {Nicolas Schmidt and Diego Lujan and Juan Andres Moraes},
#>     note = {R package version 0.1.1},
#>     url = {https://github.com/Nicolas-Schmidt/speech},
#>   }
```

#### Maintainer

Nicolas Schmidt (<nschmidt@cienciassociales.edu.uy>)
