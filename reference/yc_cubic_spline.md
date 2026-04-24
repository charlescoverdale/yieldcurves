# Fit Cubic Spline Yield Curve

Fit a yield curve using cubic spline interpolation. Provides an exact
fit through all observed data points with smooth interpolation between
them.

## Usage

``` r
yc_cubic_spline(
  maturities,
  rates,
  method = c("natural", "fmm"),
  type = c("zero", "par", "forward"),
  date = NULL
)
```

## Arguments

- maturities:

  Numeric vector of maturities in years.

- rates:

  Numeric vector of observed yields as decimals.

- method:

  Character. Spline method: `"natural"` (default) or `"fmm"` (Forsythe,
  Malcolm, and Moler).

- type:

  Character. Rate type: `"zero"` (default), `"par"`, or `"forward"`.

- date:

  Optional Date for the curve.

## Value

A `yc_curve` object with `method = "cubic_spline"`.

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_cubic_spline(maturities, rates)
fit
#> 
#> ── Yield Curve (Cubic Spline) ──────────────────────────────────────────────────
#> • Type: "zero"
#> • Maturities: 7 (0.25Y to 30Y)
#> • Rate range: 4% to 5.2%
#> • RMSE: "0" bps
```
