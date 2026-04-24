# Coupon Bond Duration and Convexity

Compute Macaulay duration, modified duration, and convexity for a
coupon-bearing bond.

## Usage

``` r
yc_bond_duration(
  face = 100,
  coupon_rate,
  maturity,
  yield,
  frequency = 2,
  compounding = c("semi_annual", "annual", "continuous")
)
```

## Arguments

- face:

  Numeric. Face (par) value of the bond. Default is 100.

- coupon_rate:

  Numeric. Annual coupon rate as a decimal (e.g., 0.05 for 5 percent).

- maturity:

  Numeric. Time to maturity in years.

- yield:

  Numeric. Yield to maturity as a decimal.

- frequency:

  Integer. Coupon frequency per year: 1 for annual or 2 for semi-annual
  (default).

- compounding:

  Character. Compounding convention: `"semi_annual"` (default),
  `"annual"`, or `"continuous"`.

## Value

A list with components `macaulay_duration`, `modified_duration`,
`convexity`, and `price`.

## Examples

``` r
# 2-year 5% bond at 4% yield, semi-annual coupons
yc_bond_duration(face = 100, coupon_rate = 0.05, maturity = 2,
                 yield = 0.04, frequency = 2)
#> $macaulay_duration
#> [1] 1.928783
#> 
#> $modified_duration
#> [1] 1.890964
#> 
#> $convexity
#> [1] 4.578047
#> 
#> $price
#> [1] 101.9039
#> 
```
