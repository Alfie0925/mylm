# mylm

`mylm` is a lightweight R package that implements a simplified version of the
ordinary least squares (OLS) linear regression model, similar to `stats::lm()`.
This package is developed as part of **Biostat 625 Homework 4**.

---

## Features

- Fit linear regression models using the normal equations  

  $\hat{\beta} = (X^T X)^{-1} X^T y$

- Accepts R **formula interface** (e.g., `y ~ x1 + x2`)
- Automatically constructs the model matrix using `model.matrix()`
- Returns:
  - coefficient estimates  
  - fitted values  
  - residuals  
  - model matrix and response  
- Documentation generated via **roxygen2**

---

## Limitations

Your current implementation has the following constraints:

### Missing values (NA) are not supported
If any NA appears in predictors or response:

```r
my_lm(...)
# Error: NA values detected: my_lm() does not support missing data.
