# Key Rate Durations

Compute key rate durations by bumping the yield curve at specific
tenors. Each bump is triangular: the full shift is applied at the key
rate tenor and linearly interpolated to zero at adjacent key rate
tenors.

## Usage

``` r
yc_key_rate_duration(
  coupon_rate,
  maturity,
  curve,
  key_rates = c(1, 2, 5, 10, 30),
  shift = 1e-04,
  face = 100,
  frequency = 2
)
```

## Arguments

- coupon_rate:

  Numeric. Annual coupon rate as a decimal.

- maturity:

  Numeric. Time to maturity in years.

- curve:

  Either a `yc_curve` object or a list/data frame with components
  `maturities` and `rates`.

- key_rates:

  Numeric vector of key rate tenors in years. Default is
  `c(1, 2, 5, 10, 30)`.

- shift:

  Numeric. Size of the rate bump in decimal (default 0.0001, i.e. 1
  basis point).

- face:

  Numeric. Face value. Default is 100.

- frequency:

  Integer. Coupon frequency: 1 (annual) or 2 (semi-annual, default).

## Value

A data frame with columns `tenor` and `key_rate_duration`.

## Examples

``` r
curve <- yc_curve(c(1, 2, 5, 10, 30), c(0.03, 0.035, 0.04, 0.042, 0.045))
yc_key_rate_duration(coupon_rate = 0.04, maturity = 10,
                     curve = curve, key_rates = c(1, 2, 5, 10, 30))
#>   tenor key_rate_duration
#> 1     1        0.03784189
#> 2     2        0.18705915
#> 3     5        0.69145153
#> 4    10        7.05548982
#> 5    30        0.00000000
```
