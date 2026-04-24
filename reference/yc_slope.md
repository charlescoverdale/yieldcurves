# Yield Curve Slope Measures

Compute common slope and curvature measures from a yield curve.

## Usage

``` r
yc_slope(curve)
```

## Arguments

- curve:

  A `yc_curve` object.

## Value

A named list with slope measures:

- spread_2s10s:

  10-year minus 2-year rate (the most common slope measure).

- spread_2s30s:

  30-year minus 2-year rate.

- spread_5s30s:

  30-year minus 5-year rate.

- spread_3m10y:

  10-year minus 3-month rate (term premium proxy).

- butterfly_2s5s10s:

  2 \* 5-year minus 2-year minus 10-year (curvature measure).

Returns NA for any measure whose required tenors fall outside the curve
range.

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_slope(fit)
#> $spread_2s10s
#> [1] -0.004597924
#> 
#> $spread_2s30s
#> [1] -0.002410197
#> 
#> $spread_5s30s
#> [1] 0.001620633
#> 
#> $spread_3m10y
#> [1] -0.01086337
#> 
#> $butterfly_2s5s10s
#> [1] -0.003463737
#> 
```
