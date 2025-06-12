```r
# If you are developing the package:
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::load_all()   # Loads the package functions
devtools::test()       # Runs all tests in tests/testthat
```