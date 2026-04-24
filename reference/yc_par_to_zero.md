# Convert Par Rates to Zero Rates

Bootstrap zero (spot) rates from par (coupon) rates using iterative
stripping.

## Usage

``` r
yc_par_to_zero(maturities, par_rates, frequency = 1)
```

## Arguments

- maturities:

  Numeric vector of maturities in years (must be positive integers or
  half-years).

- par_rates:

  Numeric vector of par rates as decimals.

- frequency:

  Integer. Coupon frequency per year: 1 for annual (default) or 2 for
  semi-annual.

## Value

A data frame with columns `maturity` and `zero_rate`.

## Examples

``` r
maturities <- c(1, 2, 3, 5, 10)
par_rates <- c(0.040, 0.042, 0.043, 0.044, 0.045)
yc_par_to_zero(maturities, par_rates)
#>   maturity  zero_rate
#> 1        1 0.04000000
#> 2        2 0.04204208
#> 3        3 0.04307249
#> 4        5 0.04413626
#> 5       10 0.04528185

# Semi-annual coupons
yc_par_to_zero(c(0.5, 1, 2), c(0.04, 0.042, 0.043), frequency = 2)
#>   maturity  zero_rate
#> 1      0.5 0.04000000
#> 2      1.0 0.04202102
#> 3      2.0 0.04304341
```
