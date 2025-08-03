# Testing Guide for metapsyData Package

## Local Development Testing

```r
# If you are developing the package:
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::load_all()   # Loads the package functions
devtools::test()       # Runs all tests in tests/testthat
```

## Automated Testing with GitHub Actions

This package uses GitHub Actions for continuous integration and automated testing. The following workflows are configured:

### 🔄 **Workflows Setup**

Three GitHub Actions workflows are configured in `.github/workflows/`:

1. **`R-CMD-check.yml`** - Comprehensive package checking
   - Tests across Ubuntu, Windows, and macOS
   - Tests with R release and development versions
   - Runs full `R CMD check` (tests, documentation, examples)

2. **`test-coverage.yml`** - Test coverage reporting
   - Runs tests and generates coverage reports
   - Uploads coverage to Codecov
   - Fast feedback on test coverage

3. **`ci.yml`** - Simple continuous integration
   - Basic test execution for quick feedback
   - Ideal for rapid development cycles

### 🚀 **Automatic Triggers**

Tests run automatically on:
- Every push to `master` or `main` branch
- Every pull request targeting `master` or `main`

### 🛠️ **Local Testing Script**

For comprehensive local testing, use the bash script:

```bash
# Run the comprehensive test script
./scripts/run_tests.sh
```

This script performs:
- Package loading with `devtools::load_all()`
- Test execution with `devtools::test()`
- Full package check with `devtools::check()`
- Optional test coverage report generation

### 📊 **Status Badges**

Add these badges to your main README.md to show build status:

```markdown
[![R-CMD-check](https://github.com/your-username/metapsyData/workflows/R-CMD-check/badge.svg)](https://github.com/your-username/metapsyData/actions)
[![Codecov test coverage](https://codecov.io/gh/your-username/metapsyData/branch/master/graph/badge.svg)](https://codecov.io/gh/your-username/metapsyData?branch=master)
```

### 📁 **File Structure**

```
metapsyData/
├── .github/
│   └── workflows/
│       ├── R-CMD-check.yml      # Comprehensive testing
│       ├── test-coverage.yml    # Coverage reporting
│       └── ci.yml               # Simple CI
├── scripts/
│   └── run_tests.sh            # Local testing script
└── tests/
    ├── testthat/               # Test files location
    └── readme.md              # This file
```

### 💡 **Development Workflow**

1. **Write tests** in `tests/testthat/`
2. **Test locally** using `devtools::test()` or `./scripts/run_tests.sh`
3. **Commit and push** - GitHub Actions will automatically run tests
4. **Check results** in the GitHub Actions tab of your repository

The automated testing ensures code quality and catches issues before they reach production!

