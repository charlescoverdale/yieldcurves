# Compute Discount Factors

Calculate discount factors from a yield curve assuming continuous
compounding.

## Usage

``` r
yc_discount(
  curve,
  maturities = NULL,
  compounding = c("continuous", "annual", "semi_annual")
)
```

## Arguments

- curve:

  A `yc_curve` object.

- maturities:

  Optional numeric vector of maturities. If NULL, uses the curve's own
  maturities.

- compounding:

  Character. Compounding convention: `"continuous"` (default),
  `"annual"`, or `"semi_annual"`.

## Value

A data frame with columns `maturity` and `discount_factor`.

## Examples

``` r
maturities <- c(1, 2, 5, 10)
rates <- c(0.045, 0.043, 0.042, 0.040)
curve <- yc_curve(maturities, rates)
yc_discount(curve)
#>   maturity discount_factor
#> 1        1       0.9559975
#> 2        2       0.9175942
#> 3        5       0.8105842
#> 4       10       0.6703200
yc_discount(curve, compounding = "annual")
#>   maturity discount_factor
#> 1        1       0.9569378
#> 2        2       0.9192452
#> 3        5       0.8140694
#> 4       10       0.6755642
```
