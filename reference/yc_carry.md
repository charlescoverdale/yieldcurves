# Carry and Roll-Down Analysis

Decompose expected return from holding a bond into carry (yield income
minus financing cost) and roll-down (capital gain from sliding down the
curve).

## Usage

``` r
yc_carry(curve, maturities = NULL, horizon = 1/12, funding_rate = NULL)
```

## Arguments

- curve:

  A `yc_curve` object.

- maturities:

  Numeric vector of bond maturities to analyse. If NULL, uses the
  curve's own maturities (excluding the shortest).

- horizon:

  Numeric. Holding period in years. Default is `1/12` (one month).

- funding_rate:

  Optional numeric. Overnight funding rate as a decimal. If NULL, uses
  the shortest rate on the curve.

## Value

A data frame with columns `maturity`, `carry`, `rolldown`, and `total`.

## Examples

``` r
maturities <- c(0.25, 1, 2, 5, 10, 30)
rates <- c(0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_carry(fit)
#>   maturity         carry      rolldown         total
#> 1     0.25 -4.349726e-05 -4.303704e-05 -0.0000865343
#> 2     1.00 -2.177943e-04 -1.951162e-04 -0.0004129104
#> 3     2.00 -4.027466e-04 -3.125082e-04 -0.0007152547
#> 4     5.00 -7.266791e-04 -3.273976e-04 -0.0010540767
#> 5    10.00 -8.639010e-04 -2.377275e-05 -0.0008876737
#> 6    30.00 -6.161240e-04  3.151354e-04 -0.0003009886
```
