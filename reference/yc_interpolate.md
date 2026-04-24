# Interpolate Yield Curve

Interpolate rates at arbitrary maturities from an observed or fitted
yield curve.

## Usage

``` r
yc_interpolate(curve, maturities, method = c("linear", "log_linear", "cubic"))
```

## Arguments

- curve:

  A `yc_curve` object.

- maturities:

  Numeric vector of maturities at which to interpolate.

- method:

  Character. Interpolation method: `"linear"` (default), `"log_linear"`,
  or `"cubic"`.

## Value

A data frame with columns `maturity` and `rate`.

## Examples

``` r
maturities <- c(1, 2, 5, 10, 30)
rates <- c(0.045, 0.043, 0.042, 0.040, 0.043)
curve <- yc_curve(maturities, rates)
yc_interpolate(curve, c(3, 7, 15, 20))
#>   maturity       rate
#> 1        3 0.04266667
#> 2        7 0.04120000
#> 3       15 0.04075000
#> 4       20 0.04150000
```
