# Convert Zero Rates to Par Rates

Compute par (coupon) rates from zero (spot) rates. The par rate for
maturity T is the coupon rate that makes a bond price equal to par.

## Usage

``` r
yc_zero_to_par(maturities, zero_rates, frequency = 1)
```

## Arguments

- maturities:

  Numeric vector of maturities in years.

- zero_rates:

  Numeric vector of zero rates as decimals.

- frequency:

  Integer. Coupon frequency per year: 1 for annual (default) or 2 for
  semi-annual.

## Value

A data frame with columns `maturity` and `par_rate`.

## Examples

``` r
maturities <- c(1, 2, 3, 5, 10)
zero_rates <- c(0.040, 0.042, 0.043, 0.044, 0.045)
yc_zero_to_par(maturities, zero_rates)
#>   maturity   par_rate
#> 1        1 0.04000000
#> 2        2 0.04195883
#> 3        3 0.04292951
#> 4        5 0.04388681
#> 5       10 0.04481069

# Semi-annual coupons
yc_zero_to_par(c(0.5, 1, 2), c(0.04, 0.042, 0.043), frequency = 2)
#>   maturity   par_rate
#> 1      0.5 0.04000000
#> 2      1.0 0.04197921
#> 3      2.0 0.04296526
```
