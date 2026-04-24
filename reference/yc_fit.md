# Fit a Yield Curve

Unified interface for fitting a yield curve using different methods.
Dispatches to
[`yc_nelson_siegel()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_nelson_siegel.md),
[`yc_svensson()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_svensson.md),
or
[`yc_cubic_spline()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_cubic_spline.md).

## Usage

``` r
yc_fit(
  maturities,
  rates,
  method = c("nelson_siegel", "svensson", "cubic_spline"),
  type = c("zero", "par", "forward"),
  date = NULL,
  ...
)
```

## Arguments

- maturities:

  Numeric vector of maturities in years.

- rates:

  Numeric vector of observed yields as decimals.

- method:

  Character. Fitting method: `"nelson_siegel"` (default), `"svensson"`,
  or `"cubic_spline"`.

- type:

  Character. Rate type: `"zero"` (default), `"par"`, or `"forward"`.

- date:

  Optional Date for the curve.

- ...:

  Additional arguments passed to the fitting function.

## Value

A `yc_curve` object.

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
fit <- yc_fit(maturities, rates, method = "nelson_siegel")
fit
#> 
#> ── Yield Curve (Nelson-Siegel) ─────────────────────────────────────────────────
#> • Type: "zero"
#> • Maturities: 7 (0.25Y to 30Y)
#> • Rate range: 4% to 5.2%
#> • RMSE: "4.7" bps
#> • Parameters: beta0=0.04444, beta1=0.00837, beta2=-0.02454, tau=3
```
