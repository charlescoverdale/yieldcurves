# Fit Svensson Yield Curve

Estimate a Svensson (1994) yield curve model from observed maturity-rate
pairs. Extends Nelson-Siegel by adding a second curvature term with its
own decay parameter, providing greater flexibility for curves with two
humps.

## Usage

``` r
yc_svensson(
  maturities,
  rates,
  tau1_init = 1,
  tau2_init = 5,
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

- tau1_init:

  Numeric. Initial value for the first decay parameter. Default is 1.

- tau2_init:

  Numeric. Initial value for the second decay parameter. Default is 5.

- weights:

  Optional numeric vector of weights for each observation. Must be the
  same length as `maturities`. If NULL (default), all observations are
  equally weighted.

- type:

  Character. Rate type: `"zero"` (default), `"par"`, or `"forward"`.

- date:

  Optional Date for the curve.

## Value

A `yc_curve` object with `method = "svensson"` and `params` containing
`beta0`, `beta1`, `beta2`, `beta3`, `tau1`, and `tau2`.

## References

Svensson, L.E.O. (1994). Estimating and Interpreting Forward Interest
Rates: Sweden 1992–1994. *NBER Working Paper*, 4871.
[doi:10.3386/w4871](https://doi.org/10.3386/w4871)

## Examples

``` r
maturities <- c(0.25, 0.5, 1, 2, 3, 5, 7, 10, 20, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.043, 0.042, 0.041,
           0.040, 0.042, 0.043)
fit <- yc_svensson(maturities, rates)
fit
#> 
#> ── Yield Curve (Svensson) ──────────────────────────────────────────────────────
#> • Type: "zero"
#> • Maturities: 10 (0.25Y to 30Y)
#> • Rate range: 4% to 5.2%
#> • RMSE: "2.6" bps
#> • Parameters: beta0=0.04703, beta1=0.00698, beta2=-0.02848, beta3=-0.01169,
#>   tau1=5, tau2=1
```
