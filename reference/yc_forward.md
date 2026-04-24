# Extract Forward Rates

Compute forward rates from a yield curve. Can compute either
instantaneous forward rates or forward-forward rates between two tenors.

## Usage

``` r
yc_forward(curve, maturities = NULL, horizon = NULL)
```

## Arguments

- curve:

  A `yc_curve` object.

- maturities:

  Optional numeric vector of maturities at which to compute forward
  rates. If NULL, uses the curve's own maturities.

- horizon:

  Optional numeric. If provided, computes the forward rate from each
  maturity to maturity + horizon (forward-forward rate).

## Value

A data frame with columns `maturity` and `forward_rate`.

## Details

The instantaneous forward rate is derived as: \$\$f(m) = r(m) + m \cdot
r'(m)\$\$

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_forward(fit)
#>   maturity forward_rate
#> 1     0.25   0.05025837
#> 2     0.50   0.04806223
#> 3     1.00   0.04457581
#> 4     2.00   0.04033815
#> 5     5.00   0.03829762
#> 6    10.00   0.04182315
#> 7    30.00   0.04443227
yc_forward(fit, maturities = c(1, 5, 10), horizon = 1)
#>   maturity forward_rate
#> 1        1   0.04220179
#> 2        5   0.03859638
#> 3       10   0.04209786
```
