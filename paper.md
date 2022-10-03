---
title: 'speech: An R package to convert legislative speeches to tidy and clean data.frame.'
authors:
- affiliation: '1'
  name: Nicolás Schmidt
  orcid: 0000-0001-5083-5792
- affiliation: '1'
  name: Diego Luján
  orcid: 0000-0002-2045-7652
- affiliation: '1'
  orcid: 0000-0003-1405-7975
  name: Juan Andres Moraes

date: "26 September 2022"
output: pdf_document
bibliography: paper.bib

tags:
- R
- text analysis
- political science


affiliations:
- index: 1
  name: Dept. of Political Science. Universidad de la Republica, UY
---

# Summary
Political scientists have sought to estimate legislators' policy preferences based on different sources of data (e.g. roll-call votes, party manifesto, discourses) \citep{Laver1, Jackman2, basicspace, Poole1, PooleR, budge1}. While congressional roll-call votes and party manifestos are widely used, political discourses like legislative speeches present some limitations for estimating policy preferences. On the one hand, the amount of text involved in legislative sessions, and the need for reliable and systematic coding leads to significant demand for manual work, since coding and systematizing large volumes of text from manual work is onerous for one or even several encoders. On the other hand, one key attribute of legislative speech is its multi-speaker nature, since several legislators speak in a single session. This imposes an additional hurdle to the task of systematizing individual speeches from legislative documents. This R package provides several functionalities to overcome these limitations by providing an automatized procedure to systematize and compile legislative speeches. The functions included in the package allow the systematic treatment of large volumes of text, in particular, those referred to collective actors (like parliaments) in which there is a large number of individual speakers that belong to other collective actors like parties, factions or legislative committees. The second main source of data to estimate the ideological positions of legislators and parties is the voting records. Roll-call votes are the named record of what individual legislators vote on a particular issue in congress. Not all countries use mandatory roll-call voting procedure in their national legislatures \citep{ainsley2020roll}. Some countries, both in Latin America and Europe only use roll-call voting for particular issues or at request by an individual legislator or a group of them. This package also provides a set of functions to: i) automatically detect roll-call votes; and ii) compile them into an ordered format ready for use in multidimensional scaling routines such as W-nominate \citep{OC, Poole1}.


# Motivation and Description

The main problem that the speech package solves is the conversion of textual information in dialogue format such as parliamentary speeches to an ordered data set where it is possible to obtain the speech of each of the legislators in a parliamentary session. For this purpose, a search engine with regular expressions was designed to identify each time a legislator takes the floor and delivers a speech. Since we are interested in gathering and ordering individual speeches, it is important to identify floor speeches by legislator. To this end, the package allows to detect each of the speaking legislators and their respective texts in order to later advance with the incorporation of additional variables that allow for relevant statistical analysis according to different attributes (political party, sex, district, among others).

By way of example, Figure \ref{f1} shows a conventional session diary and the following two figures (\ref{f2}, \ref{f3})show the parts of the text in pdf format that the speech package identifies and extracts to compile an ordered data set.



\begin{figure}[htpb!]
  \includegraphics{figpaper/f1.png}
  \caption{...}
  \label{f1}
\end{figure}

\begin{figure}[htpb!]
  \includegraphics{figpaper/f2.png}
  \caption{...}
  \label{f2}
\end{figure}

\begin{figure}[htpb!]
  \includegraphics{figpaper/f3.png}
  \caption{...}
  \label{f3}
\end{figure}



# speech R Package

`speech` provides an easy way for collecting, systematizing and compiling legislative speeches from legislative minutes coming from parliamentary web pages as well as formal registry of legislative sessions, like .pdf documents.
The functions included in the package allow researchers interested in legislative behavior for carrying out several procedures based on legislatve speeches.

 
* `speech_build` allows to perform the first text-extraction from a .pdf document to a tidy data frame. This first text extraction assumes that some corrections may be necessary, which is why the package provides additional functions like:`speech_url`, `speech_check`, `speech_legis_replace`, `speech_view`.

	* `speech_url` the main function of the package (`speech_build`) requires as input a pdf file containing the parliamentary speeches. This input document can be hosted 	locally or can be downloaded directly from the Uruguayan congress page with this function. In this function it is possible to set date ranges or specific dates.

	* `speech_check` cheks legislators' names recovered by `speech_build` to ensure they are correctly spelled. Also, and given that the primary unit of analysis is the individual legislator, this function  allows verifying that all speeches coming from the same individual are compiled under the same name. 

	* `speech_legis_replace` follows speech_check and allos to change a legislator's name if nedeed, after which the function `speech_recompiler` must be used.

	* `speech_view` enables the visualization of possible errors on legislators' names (e.g. if two legislators have the same name and they have to be distinguished).
	If this is the case `speech_legis_replace` can be used.
	
	* `speech_recompiler` allows to group the speech according to different variables: chamber, date, legislature, gender and others.


* `speech_rollcall` This function performs a search within the text of rollcall votes and compiles a dataset in which each row is the vote of a legislator from one of the chambers of congress.



# Applications

``` r
library(speech)
urls <- speech_url(chamber = "D", days = c("12-06-2002", "14-04-2004"))

text <- speech_build(file =  urls)
print(text)
```

```
# A tibble: 259 x 7
   legislator  speech                                     chamber date       legislature id      sex
   <chr>       <chr>                                      <chr>   <date>           <int> <chr> <dbl>
 1 SEÑORALE    "SEÑOR SEÑORALE, Representante por Salto\~ CAMARA~ 2002-06-12          45 0?wi~     0
 2 MORALES     "SEÑOR MORALES. Señor Presidente: quiero ~ CAMARA~ 2002-06-12          45 0?wi~     1
 3 MELLO       "SEÑOR MELLO. Señor Presidente: la preocu~ CAMARA~ 2002-06-12          45 0?wi~     1
 4 FONTICIELLA "SEÑOR FONTICIELLA. Señor Presidente: en ~ CAMARA~ 2002-06-12          45 0?wi~     1
 5 LEGNANI     "SEÑOR LEGNANI. Señor Presidente: en esto~ CAMARA~ 2002-06-12          45 0?wi~     1
 6 MAHIA       "SEÑOR MAHIA. Señor Presidente: hace un p~ CAMARA~ 2002-06-12          45 0?wi~     1
 7 LAVIÑA      "SEÑOR LAVIÑA. Señor Presidente: en su op~ CAMARA~ 2002-06-12          45 0?wi~     1
 8 BARRIOS     "SEÑOR BARRIOS. ¡Que se comunique de inme~ CAMARA~ 2002-06-12          45 0?wi~     1
 9 LAVIÑA      "SEÑOR LAVIÑA. Señor Presidente: este Pro~ CAMARA~ 2002-06-12          45 0?wi~     1
10 MELGAREJO   "SEÑOR MELGAREJO. ¡Que se comunique de in~ CAMARA~ 2002-06-12          45 0?wi~     1
# ... with 249 more rows
> 
```



``` r
rollcall <- speech_rollcall(file =  urls)

print(rollcall)
```

```
# A tibble: 165 x 10
   legislator         vote argument speech       chamber date       legislature rollcall id      sex
   <chr>             <dbl>    <dbl> <chr>        <chr>   <date>           <int>    <int> <chr> <dbl>
 1 ABDALA                0        0 SEÑOR ABDAL~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 2 AGAZZI                1        1 SEÑOR AGAZZ~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 3 AMEN VAGHETTI         0        0 SEÑOR AMEN ~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 4 AMORIN BATLLE         0        0 SEÑOR AMORI~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 5 ARAUJO                0        1 SEÑOR ARAUJ~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 6 ARGENZIO              0        1 SEÑOR ARGEN~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 7 ARGIMON               0        0 SEÑORA ARGI~ CAMARA~ 2002-06-12          45        1 0?wi~     0
 8 ARRARTE FERNANDEZ     1        0 SEÑOR ARRAR~ CAMARA~ 2002-06-12          45        1 0?wi~     1
 9 ARREGUI               1        1 SEÑOR ARREG~ CAMARA~ 2002-06-12          45        1 0?wi~     1
10 BARAIBAR              1        0 SEÑOR BARAI~ CAMARA~ 2002-06-12          45        1 0?wi~     1
# ... with 155 more rows
>
```

``` r
summary(rollcall)
```


```
# A tibble: 2 x 10
  Chamber Date       Legislators Affirmative Negative prop_AF prop_NG prop_women prop_arg    rc
  <chr>   <date>           <int>       <dbl>    <dbl>   <dbl>   <dbl>      <dbl>    <dbl> <int>
1 CRR     2002-06-12          92          45       47    48.9    51.1       13.0     48.9     1
2 CRR     2004-04-14          73          32       41    43.8    56.2       15.1     11.0     1
> 

```

# Availability

`speech` is an open source software made available under the GPL-3 license. It can be installed from CRAN: `install.packages("speech")`.






# References

[@...] # citation ref


