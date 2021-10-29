# speech 0.1.4

* {tabulizer} functions are replaced by {tm} functions.


# speech 0.1.3

 * add `speech_url()`
 * add `speech_uncompiler()`

# speech 0.1.2

* variable sex added in output function `speech_build()`
* argument `rm.name` in `speech_word_count()` added

# speech 0.1.1

* change `dplyr::bind_rows()` for `do.call(rbind, .)`
* change `dplyr::mutate()` for `transform()`
* typeof legislature variable now is numeric in `speech::speech_recompiler()`
* typeof date variable now is date
* The value of the `compiler_by` argument in the `speech_recompailer()` function is modified. 
Before: `c("legislator", "legislature", "chamber", "party")`, now: `c("legislator", "legislature", "chamber", "date", "id")`


# speech 0.1.0

* CRAN-RELEASE
