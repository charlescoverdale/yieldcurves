# Extract Level, Slope, and Curvature Factors

For Nelson-Siegel or Svensson curves, extracts the estimated factors
directly from the model parameters. For other curves, computes empirical
measures.

## Usage

``` r
yc_level_slope_curvature(curve)
```

## Arguments

- curve:

  A `yc_curve` object.

## Value

A named list with:

- level:

  Long-run level (beta0 for NS/Svensson, or mean rate).

- slope:

  Slope factor (beta1 for NS/Svensson, or short - long rate).

- curvature:

  Curvature factor (beta2 for NS/Svensson, or 2\*mid - short - long
  rate).

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
yc_level_slope_curvature(fit)
#> $level
#> [1] 0.04444303
#> 
#> $slope
#> [1] 0.008365845
#> 
#> $curvature
#> [1] -0.02454161
#> 
```
