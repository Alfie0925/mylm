#' Fit a simple linear regression model using ordinary least squares
#'
#' @description
#' Simplified OLS estimator based on beta_hat = (X^T X)^{-1} X^T y.
#'
#' @param formula Model formula, e.g., y ~ x1 + x2.
#' @param data Data frame containing variables.
#'
#' @return An object of class "my_lm".
#'
#' @examples
#' dat = mtcars
#' fit = my_lm(mpg ~ wt + hp, data = dat)
#' fit$coefficients
#'
#' @export
my_lm = function(formula, data) {

  # build model frame from formula and data
  mf = stats::model.frame(formula = formula, data = data, na.action = NULL)

  # extract response and design matrix
  y = stats::model.response(mf)
  X = stats::model.matrix(attr(mf, "terms"), data = mf)

  # check missing values
  if (any(is.na(X)) || any(is.na(y))) {
    stop("NA values detected: my_lm() does not support missing data.")
  }

  # solve normal equations (X^T X beta = X^T y)
  beta_hat = cpp_ols_normal_eq(X, y)

  # add names to coefficients
  names(beta_hat) = colnames(X)

  # compute fitted values and residuals
  fitted = as.vector(X %*% beta_hat)
  residuals = as.vector(y - fitted)

  # add names to fitted and residuals (row names of data)
  names(fitted) = rownames(X)
  names(residuals) = rownames(X)

  # return result
  result = list(
    coefficients = beta_hat,
    fitted.values = fitted,
    residuals = residuals,
    call = match.call(),
    X = X,
    y = y,
    terms = attr(mf, "terms")
  )

  class(result) = "my_lm"
  return(result)
}
