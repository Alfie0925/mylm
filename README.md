# mylm

`mylm` is a lightweight R package that implements a simplified version of the
ordinary least squares (OLS) linear regression model, similar to `stats::lm()`.
This package is developed as part of **Biostat 625 Homework 4**.

---

# Features

- Fit linear regression models using the normal equations  
  \[
  \hat\beta = (X^T X)^{-1} X^T y
  \]
- Accepts R **formula interface** (e.g., `y ~ x1 + x2`)
- Automatically constructs the model matrix using `model.matrix()`
- Returns:
  - coefficient estimates  
  - fitted values  
  - residuals  
  - model matrix and response  
- Includes a basic `summary.my_lm()` method with standard errors and t-statistics  
- Documentation generated via **roxygen2**

---

# Installation

You can install the package directly from GitHub:

```r
# install.packages("devtools")
devtools::install_github("Alfie0925/mylm")
