# Z-Spread

Compute the Z-spread (zero-volatility spread) for a bond. The Z-spread
is the constant spread added to each zero rate on the benchmark curve
that makes the discounted cash flows equal the market price.

## Usage

``` r
yc_zspread(price, coupon_rate, maturity, curve, face = 100, frequency = 2)
```

## Arguments

- price:

  Numeric. Market price of the bond.

- coupon_rate:

  Numeric. Annual coupon rate as a decimal.

- maturity:

  Numeric. Time to maturity in years.

- curve:

  Either a `yc_curve` object or a list/data frame with components
  `maturities` and `rates`.

- face:

  Numeric. Face value of the bond. Default is 100.

- frequency:

  Integer. Coupon frequency per year: 1 for annual or 2 for semi-annual
  (default).

## Value

A list with components `zspread` (the Z-spread as a decimal), `price`
(the input price), and `model_price` (the price implied by the curve
with the Z-spread applied).

## Examples

``` r
# Create a benchmark curve
curve <- yc_curve(c(0.5, 1, 2, 5, 10), c(0.03, 0.035, 0.04, 0.042, 0.045))

# A bond priced below par (positive Z-spread)
yc_zspread(price = 95, coupon_rate = 0.04, maturity = 5,
           curve = curve, frequency = 2)
#> $zspread
#> [1] 0.01029722
#> 
#> $price
#> [1] 95
#> 
#> $model_price
#> [1] 95
#> 
```
