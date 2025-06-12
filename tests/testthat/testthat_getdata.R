# tests/testthat/test-getData.R

library(testthat)
library(metapsyData) # 如果你的包还没安装，先用 devtools::load_all() 加载

all_data <- listData()
message("getData works for existing data")
total <- length(all_data$shorthand)
for (i in seq_along(all_data$shorthand)) {
    shorthand <- all_data$shorthand[i]
    message(sprintf("[%d/%d] Testing getData for: %s", i, total, shorthand))
    test_that(paste("getData works for data:", shorthand), {
        skip_on_cran()
        expect_message(
            getData(shorthand),
            regexp = "Download successful",
            all = TRUE
        )
        d <- suppressMessages(getData(shorthand))
        expect_true(is.list(d) || "R6" %in% class(d)) # Return value is OOP/class-based object
        # Could also check if the data has the expected structure 
    })
}
message("getData errors for nonexistent data")
test_that("getData errors for invalid shorthand", {
    expect_error(getData("nonexistent-database"))
})
message("getData returns dataframe")
for (i in seq_along(all_data$shorthand)) {
    shorthand <- all_data$shorthand[i]
    message(sprintf("[%d/%d] Testing getData for: %s", i, total, shorthand))
    test_that(paste("getData returns data.frame for data:", shorthand), {
        skip_on_cran()
        d <- getData(shorthand, include.metadata = FALSE)
        expect_s3_class(d, "data.frame") #check if the returned object is a data.frame
    })
}
