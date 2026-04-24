# Duration and Convexity

Compute Macaulay duration, modified duration, and convexity for
zero-coupon bonds at each maturity on the curve.

## Usage

``` r
yc_duration(
  curve,
  maturities = NULL,
  compounding = c("continuous", "annual", "semi_annual")
)
```

## Arguments

- curve:

  A `yc_curve` object.

- maturities:

  Optional numeric vector of maturities. If NULL, uses the curve's own
  maturities.

- compounding:

  Character. Compounding convention: `"continuous"` (default),
  `"annual"`, or `"semi_annual"`.

## Value

A data frame with columns `maturity`, `macaulay_duration`,
`modified_duration`, and `convexity`.

## Examples

``` r
maturities <- c(0.25, 1, 2, 5, 10, 30)
rates <- c(0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_duration(fit)
#>   maturity macaulay_duration modified_duration convexity
#> 1     0.25              0.25              0.25    0.0625
#> 2     1.00              1.00              1.00    1.0000
#> 3     2.00              2.00              2.00    4.0000
#> 4     5.00              5.00              5.00   25.0000
#> 5    10.00             10.00             10.00  100.0000
#> 6    30.00             30.00             30.00  900.0000
```
