# Fit Nelson-Siegel Yield Curve

Estimate a Nelson-Siegel (1987) yield curve model from observed
maturity-rate pairs. The model decomposes the yield curve into three
factors: level, slope, and curvature.

## Usage

``` r
yc_nelson_siegel(
  maturities,
  rates,
  tau_init = 1,
  weights = NULL,
  type = c("zero", "par", "forward"),
  date = NULL
)
```

## Arguments

- maturities:

  Numeric vector of maturities in years.

- rates:

  Numeric vector of observed yields as decimals.

- tau_init:

  Numeric. Initial value for the decay parameter tau. Default is 1.

- weights:

  Optional numeric vector of weights for each observation. Must be the
  same length as `maturities`. Useful for emphasising liquid tenors. If
  NULL (default), all observations are equally weighted.

- type:

  Character. Rate type: `"zero"` (default), `"par"`, or `"forward"`.

- date:

  Optional Date for the curve.

## Value

A `yc_curve` object with `method = "nelson_siegel"` and `params`
containing `beta0`, `beta1`, `beta2`, and `tau`.

## Details

The Nelson-Siegel model is: \$\$r(m) = \beta_0 + \beta_1 \frac{1 -
e^{-m/\tau}}{m/\tau} + \beta_2 \left(\frac{1 - e^{-m/\tau}}{m/\tau} -
e^{-m/\tau}\right)\$\$

## References

Nelson, C.R. and Siegel, A.F. (1987). Parsimonious Modeling of Yield
Curves. *The Journal of Business*, 60(4), 473–489.
[doi:10.1086/296409](https://doi.org/10.1086/296409)

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 3, 5, 7, 10, 20, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.043, 0.042, 0.041,
           0.040, 0.042, 0.043)
fit <- yc_nelson_siegel(maturities, rates)
fit
#> 
#> ── Yield Curve (Nelson-Siegel) ─────────────────────────────────────────────────
#> • Type: "zero"
#> • Maturities: 10 (0.25Y to 30Y)
#> • Rate range: 4% to 5.2%
#> • RMSE: "4.2" bps
#> • Parameters: beta0=0.04443, beta1=0.00832, beta2=-0.02424, tau=3
```
