#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cpp_ols_normal_eq(NumericMatrix X, NumericVector y) {
  int n = X.nrow();
  int p = X.ncol();

  // X^T X : p x p
  NumericMatrix XtX(p, p);
  // X^T y : p
  NumericVector Xty(p);

  // compute X^T X (use symmetry)
  for (int i = 0; i < p; i++) {
    for (int j = i; j < p; j++) {
      double sum = 0.0;
      for (int k = 0; k < n; k++) {
        sum += X(k, i) * X(k, j);
      }
      XtX(i, j) = sum;
      XtX(j, i) = sum; // symmetric
    }
  }

  // compute X^T y
  for (int j = 0; j < p; j++) {
    double sum = 0.0;
    for (int k = 0; k < n; k++) {
      sum += X(k, j) * y[k];
    }
    Xty[j] = sum;
  }

  // call base::solve(XtX, Xty) to get beta_hat
  Environment base = Environment::namespace_env("base");
  Function solve = base["solve"];

  SEXP beta_sexp = solve(XtX, Xty);
  NumericVector beta(beta_sexp);

  return beta;
}
