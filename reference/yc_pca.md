# Principal Component Analysis of Yield Curves

Perform PCA on a time series of yield curves to extract the dominant
factors (level, slope, curvature) following Litterman and Scheinkman
(1991).

## Usage

``` r
yc_pca(curves_matrix, n_components = 3, scale = FALSE)
```

## Arguments

- curves_matrix:

  Numeric matrix where each row is a yield curve observation (e.g.,
  daily curves) and each column is a tenor. Column names should be
  maturity labels.

- n_components:

  Integer. Number of principal components to retain. Default is 3
  (level, slope, curvature).

- scale:

  Logical. Whether to scale variables before PCA. Default is `FALSE`
  (use covariance matrix, standard in yield curve PCA).

## Value

A `yc_pca` object (S3 class) with components:

- loadings:

  Matrix of factor loadings (tenors x components).

- scores:

  Matrix of factor scores (observations x components).

- variance_explained:

  Numeric vector of proportion of variance explained by each component.

- cumulative_variance:

  Numeric vector of cumulative variance explained.

- sdev:

  Standard deviations of each component.

- n_components:

  Number of components retained.

- tenors:

  Column names from the input matrix.

## References

Litterman, R. and Scheinkman, J. (1991). Common Factors Affecting Bond
Returns. *The Journal of Fixed Income*, 1(1), 54–61.
[doi:10.3905/jfi.1991.692347](https://doi.org/10.3905/jfi.1991.692347)

## Examples

``` r
# Simulate 100 days of yield curves at 5 tenors
set.seed(42)
n_days <- 100
tenors <- c(1, 2, 5, 10, 30)
base_rates <- c(0.045, 0.043, 0.042, 0.040, 0.043)
curves <- matrix(NA, n_days, length(tenors))
colnames(curves) <- paste0(tenors, "Y")
level <- cumsum(rnorm(n_days, 0, 0.001))
slope <- cumsum(rnorm(n_days, 0, 0.0005))
for (i in seq_len(n_days)) {
  curves[i, ] <- base_rates + level[i] + slope[i] * (tenors - mean(tenors)) / 30
}
pca_result <- yc_pca(curves)
pca_result
#> 
#> ── Yield Curve PCA ─────────────────────────────────────────────────────────────
#> • Components: 3
#> • Tenors: 5 (1Y, 2Y, 5Y, 10Y, 30Y)
#> • PC1 (Level): 93.3% variance
#> • PC2 (Slope): 6.7% variance
#> • PC3 (Curvature): 0% variance
#> • Cumulative: 100%
```
