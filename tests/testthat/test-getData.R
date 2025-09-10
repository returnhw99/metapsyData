# tests/testthat/test-getData.R

library(testthat)
library(metapsyData) # If your package is not installed yet, use devtools::load_all() to load it

all_data <- listData()
message("getData works for existing data")
total <- length(all_data$shorthand)
for (i in seq_along(all_data$shorthand)) {
    shorthand <- all_data$shorthand[i]
    message(sprintf("[%d/%d] Testing getData for: %s", i, total, shorthand))
    test_that(paste("getData works for data:", shorthand), {
        skip_on_cran() # Skip this test on CRAN, because CRAN does not allow internet access needed for data
        d <- suppressMessages(getData(shorthand))
        expect_true( "R6" %in% class(d)) # Return value is R6class
        expect_true(is.data.frame(d$data))     #R6class is not empty
        expect_true(!is.null(d$title))
        expect_true(!is.null(d$variable.description))
        expect_true(length(d$variable.description) > 0)
    })
}
message("getData errors for nonexistent data")
test_that("getData errors for invalid shorthand", {
    expect_error(getData("nonexistent-database"))
})
message("getData returns dataframe if include.metadata = FALSE")
for (i in seq_along(all_data$shorthand)) {
    shorthand <- all_data$shorthand[i]
    message(sprintf("[%d/%d] Testing getData for: %s", i, total, shorthand))
    test_that(paste("getData returns data.frame for data:", shorthand), {
        skip_on_cran()
        d <- suppressMessages(getData(shorthand, include.metadata = FALSE))
        expect_s3_class(d, "data.frame") #check if the returned object is a data.frame
    })
}
