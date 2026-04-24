# Create a Yield Curve Object

Construct a `yc_curve` object from observed maturity-rate pairs. This is
the core data structure used throughout the package.

## Usage

``` r
yc_curve(maturities, rates, type = c("zero", "par", "forward"), date = NULL)
```

## Arguments

- maturities:

  Numeric vector of maturities in years (e.g., 0.25 for 3 months, 2 for
  2 years).

- rates:

  Numeric vector of yields as decimals (e.g., 0.05 for 5\\ Must be the
  same length as `maturities`.

- type:

  Character. The type of rate: `"zero"` (default), `"par"`, or
  `"forward"`.

- date:

  Optional Date for the curve observation.

## Value

A `yc_curve` object (S3 class) with components:

- maturities:

  Numeric vector of maturities in years.

- rates:

  Numeric vector of rates as decimals.

- type:

  Character string indicating rate type.

- method:

  Character string indicating fitting method.

- params:

  List of model parameters (empty for observed curves).

- fitted:

  Numeric vector of fitted rates (NULL for observed curves).

- residuals:

  Numeric vector of residuals (NULL for observed curves).

- date:

  Date of the curve observation.

- n_obs:

  Integer count of maturity points.

## Examples

``` r
# US Treasury yields (2Y, 5Y, 10Y, 30Y)
maturities <- c(2, 5, 10, 30)
rates <- c(0.045, 0.042, 0.040, 0.043)
curve <- yc_curve(maturities, rates)
curve
#> 
#> ── Yield Curve (Observed) ──────────────────────────────────────────────────────
#> • Type: "zero"
#> • Maturities: 4 (2Y to 30Y)
#> • Rate range: 4% to 4.5%
```
