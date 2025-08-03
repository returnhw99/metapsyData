#!/bin/bash

# R Package Testing Script
# This script runs comprehensive tests for the metapsyData package

echo "Starting R package tests..."

# Check if devtools is available, install if needed
Rscript -e "if (!requireNamespace('devtools', quietly = TRUE)) install.packages('devtools')"

# Load the package
echo "Loading package..."
Rscript -e "devtools::load_all()"

# Run tests
echo "Running tests..."
Rscript -e "devtools::test()"

# Check package
echo "Running R CMD check..."
Rscript -e "devtools::check()"

# Generate test coverage report (optional)
if command -v Rscript &> /dev/null; then
    echo "Generating test coverage report..."
    Rscript -e "if (requireNamespace('covr', quietly = TRUE)) { 
        cov <- covr::package_coverage(); 
        print(cov); 
        covr::report(cov, file = 'coverage.html') 
    } else { 
        message('covr package not installed, skipping coverage report') 
    }"
fi

echo "Tests completed!"