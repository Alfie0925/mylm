test_that("my_lm matches lm on simple cases", {
  dat = mtcars

  fit_my = my_lm(mpg ~ wt + hp, data = dat)
  fit_lm = lm(mpg ~ wt + hp, data = dat)

  # coefficients
  expect_equal(fit_my$coefficients, coef(fit_lm))

  # fitted values
  expect_equal(fit_my$fitted.values, fitted(fit_lm))

  # residuals
  expect_equal(fit_my$residuals, resid(fit_lm))
})


test_that("my_lm handles random numeric data", {
  set.seed(1)
  n = 100
  x1 = rnorm(n)
  x2 = rnorm(n)
  y  = 3 + 2*x1 - 5*x2 + rnorm(n, sd = 0.1)

  dat = data.frame(y = y, x1 = x1, x2 = x2)

  fit_my = my_lm(y ~ x1 + x2, data = dat)
  fit_lm = lm(y ~ x1 + x2, data = dat)

  expect_equal(fit_my$coefficients, coef(fit_lm), tolerance = 1e-6)
})


test_that("my_lm rejects NA values", {
  dat = mtcars
  dat$wt[1] = NA

  expect_error(
    my_lm(mpg ~ wt + hp, data = dat),
    "NA values detected"
  )
})
