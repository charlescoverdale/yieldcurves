# Predict Rates from a Fitted Yield Curve

Evaluate a fitted yield curve at new maturities.

## Usage

``` r
yc_predict(curve, maturities)
```

## Arguments

- curve:

  A `yc_curve` object from a fitting function.

- maturities:

  Numeric vector of maturities at which to predict rates.

## Value

A data frame with columns `maturity` and `rate`.

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_predict(fit, c(3, 7, 15, 20))
#>   maturity       rate
#> 1        3 0.04324635
#> 2        7 0.04056267
#> 3       15 0.04139504
#> 4       20 0.04205099
```
