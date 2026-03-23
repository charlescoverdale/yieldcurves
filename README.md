# yieldcurves

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**Yield curve fitting, analysis, and decomposition for R.**

## Why does this package exist?

Government bond yields are published daily at a handful of maturities: 1-month, 3-month, 1-year, 2-year, 5-year, 10-year, 30-year. That's what you see on a Bloomberg terminal or in a spreadsheet. But those raw data points only tell you part of the story.

In practice, fixed income analysts need to answer questions that raw yields can't:

- **"What's the implied 5-year rate, 5 years from now?"** This requires extracting forward rates from the term structure. You can't read this off a spreadsheet; it requires fitting a smooth curve and computing the instantaneous forward rate, a derivative of the zero curve that can't be read off a table.

- **"How much will I earn from holding a 10-year bond for one month?"** This is carry and roll-down analysis. Carry is the yield you earn minus your funding cost. Roll-down is the capital gain from the bond "sliding down" the curve as it ages: as the bond's remaining maturity shortens, it moves to a different point on the curve. Both require interpolating the fitted curve at fractional maturities.

- **"Are rates moving because of level shifts, slope changes, or curvature?"** Principal component analysis decomposes a time series of yield curves into orthogonal factors. Litterman and Scheinkman (1991) showed that three factors (level, slope, curvature) explain over 95% of yield curve movements. When PC1 moves, all rates move together; when PC2 moves, short and long rates move in opposite directions.

- **"What discount factor should I use for a 7.5-year cash flow?"** The Treasury publishes rates at 5, 7, and 10 years, but not 7.5. You need a fitted model to interpolate, then convert to a discount factor.

- **"How do I convert par rates to zero rates?"** Par rates (coupon bond yields) and zero rates (discount yields) are different objects. Converting between them requires iterative bootstrap stripping: solving a system of equations where each zero rate depends on all shorter zero rates.

- **"What's the duration and convexity of my portfolio at these maturities?"** These are risk measures that quantify how much bond prices change when rates move. Modified duration tells you the approximate percentage price change for a 1% rate move. Computing it at arbitrary maturities requires a fitted curve.

The Nelson-Siegel (1987) and Svensson (1994) models solve the interpolation problem elegantly by fitting the entire curve with 4-6 parameters that have economic meaning: level (long-run rate), slope (term premium), and curvature (medium-term humps). Over 20 central banks use these models for their official yield curve estimates (BIS, 2005).

`yieldcurves` puts all of this into clean, tested R functions so you can go from raw yields to forward curves, discount factors, carry analysis, and PCA decomposition in a few lines of code.

## Installation

Install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("charlescoverdale/yieldcurves")
```

## Quick start

```r
library(yieldcurves)

# Maturities in years, rates as decimals (0.05 = 5%)
maturities <- c(0.25, 0.5, 1, 2, 5, 10, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.042, 0.040, 0.043)

fit <- yc_nelson_siegel(maturities, rates)
plot(fit)
```

## Where do I get yield data?

`yieldcurves` is a pure computation package. It does not download data itself. You bring two numeric vectors:

- **maturities**: time to maturity in years (e.g., `c(0.25, 1, 2, 5, 10, 30)`)
- **rates**: yields as decimals (e.g., `c(0.052, 0.048, 0.045, 0.042, 0.040, 0.043)`)

Here are the main sources of government bond yield data and how to get them into R:

| Country | Source | Free? | R package | FRED series codes |
|---------|--------|-------|-----------|-------------------|
| US | US Treasury / FRED | Yes | [fred](https://cran.r-project.org/package=fred) | DGS1MO, DGS3MO, DGS6MO, DGS1, DGS2, DGS3, DGS5, DGS7, DGS10, DGS20, DGS30 |
| UK | Bank of England | Yes | [boe](https://cran.r-project.org/package=boe) | `boe_yield_curve()` |
| Euro area | European Central Bank | Yes | [readecb](https://cran.r-project.org/package=readecb) | `ecb_yield_curve()` |
| Japan | Ministry of Finance | Yes | Download CSV from mof.go.jp | |
| Australia | RBA | Yes | Download CSV from rba.gov.au | |
| Canada | Bank of Canada | Yes | | DGS series on FRED |
| Any | Bloomberg / Refinitiv | Paid | Rblpapi / refinitiv | |

### Step-by-step example: US Treasury yields from FRED

```r
# 1. Install the fred package (one time)
install.packages("fred")

# 2. Get a free API key from https://fred.stlouisfed.org/docs/api/api_key.html
fred::fred_set_key("your_api_key_here")

# 3. Download Treasury constant maturity rates
library(fred)
treasury <- fred_series(c("DGS1", "DGS2", "DGS5", "DGS10", "DGS30"))

# 4. Extract the most recent observation
latest <- treasury[nrow(treasury), ]
maturities <- c(1, 2, 5, 10, 30)
rates <- as.numeric(latest[, -1]) / 100  # FRED reports in percent, convert to decimal

# 5. Fit a yield curve
library(yieldcurves)
fit <- yc_nelson_siegel(maturities, rates)
plot(fit)
```

### Or just type rates in directly

You don't need an API at all. If you have yield data from any source (a spreadsheet, a Bloomberg terminal, a central bank website), just type it in:

```r
library(yieldcurves)

maturities <- c(0.25, 0.5, 1, 2, 3, 5, 7, 10, 20, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.043, 0.042, 0.041,
           0.040, 0.042, 0.043)

fit <- yc_nelson_siegel(maturities, rates)
fit
#> -- Yield Curve (Nelson-Siegel) --
#> * Type: "zero"
#> * Maturities: 10 (0.25Y to 30Y)
#> * Rate range: 4% to 5.2%
#> * RMSE: 8.6 bps
#> * Parameters: beta0=0.04127, beta1=0.01347, beta2=-0.0091, tau=1
```

## How does this compare to existing packages?

| Feature | yieldcurves | YieldCurve | termstrc |
|---------|-------------|------------|----------|
| Nelson-Siegel fitting | Yes | Yes | Yes |
| Svensson fitting | Yes | Yes | Yes |
| Cubic spline | Yes | No | Yes |
| Weighted fitting | Yes | No | No |
| Forward rates (analytical) | Yes | No | Yes |
| Discount factors | Yes | No | Yes |
| Duration and convexity | Yes | No | No |
| Z-spread | Yes | No | No |
| Key rate durations | Yes | No | No |
| Par/zero conversions | Yes | No | Yes |
| PCA decomposition | Yes | No | No |
| Carry and roll-down | Yes | No | No |
| Slope measures | Yes | No | No |
| Works with plain vectors | Yes | No (needs xts/zoo) | No |
| Base R graphics | Yes | Yes | No |
| Last updated | 2026 | 2022 | 2015 |

## Examples

### Fit a Nelson-Siegel curve

The model takes two inputs: **maturities** (in years) and **rates** (as decimals, so 5% = 0.05). It returns a fitted curve you can query at any maturity.

```r
library(yieldcurves)

maturities <- c(0.25, 0.5, 1, 2, 3, 5, 7, 10, 20, 30)
rates <- c(0.052, 0.050, 0.048, 0.045, 0.043, 0.042, 0.041,
           0.040, 0.042, 0.043)

fit <- yc_nelson_siegel(maturities, rates)
fit
#> -- Yield Curve (Nelson-Siegel) --
#> * Type: "zero"                 <-- zero-coupon (discount) rates
#> * Maturities: 10 (0.25Y to 30Y)
#> * Rate range: 4% to 5.2%
#> * RMSE: 8.6 bps               <-- fitting error; under 10 bps is a good fit
#> * Parameters: beta0=0.04127, beta1=0.01347, beta2=-0.0091, tau=1

plot(fit)
```

### Extract forward rates and discount factors

Forward rates answer "what does the market imply about future rates?" Discount factors answer "what's a future cash flow worth today?"

```r
# Forward rates at 1, 5, and 10 years
yc_forward(fit, maturities = c(1, 5, 10))
#>   maturity forward_rate
#> 1        1       0.0468   # The market implies 4.68% at the 1-year point
#> 2        5       0.0393
#> 3       10       0.0413

# Discount factors: $1 in 30 years is worth $0.28 today
yc_discount(fit, maturities = c(1, 5, 10, 30))
#>   maturity discount_factor
#> 1        1          0.9530
#> 2        5          0.8103
#> 3       10          0.6619
#> 4       30          0.2817
```

### Carry and roll-down analysis

How much do you earn from holding a bond, assuming the curve doesn't change? Carry is the coupon income minus funding cost. Roll-down is the price gain as the bond's maturity shortens and it "slides" to a lower-rate part of the curve.

```r
yc_carry(fit, maturities = c(2, 5, 10, 30))
#>   maturity     carry   rolldown      total
#> 1        2  0.000170  0.005143  0.005313   # 53 bps total on the 2Y
#> 2        5  0.000013  0.004478  0.004491   # 45 bps on the 5Y
#> 3       10 -0.000059  0.003260  0.003201   # 32 bps on the 10Y
#> 4       30  0.000033 -0.001507 -0.001474   # Negative on the 30Y (curve slopes up there)
```

### Duration and convexity

Duration measures how sensitive a bond's price is to rate changes. A modified duration of 9.6 means a 1% rate rise causes roughly a 9.6% price drop.

```r
yc_duration(maturities = c(2, 5, 10, 30), rates = c(0.045, 0.042, 0.040, 0.043))
#>   maturity macaulay modified convexity
#> 1        2     2.00     1.91      4.00
#> 2        5     5.00     4.80     25.00
#> 3       10    10.00     9.62    100.00
#> 4       30    30.00    28.80    900.00
```

### Coupon bond duration

`yc_bond_duration()` computes Macaulay duration, modified duration, and convexity for coupon-bearing bonds.

```r
# 10-year bond with 5% coupon at 4.5% yield, semi-annual coupons
yc_bond_duration(face = 100, coupon_rate = 0.05, maturity = 10,
                 yield = 0.045, frequency = 2)
#> $macaulay_duration
#> [1] 8.05
#>
#> $modified_duration
#> [1] 7.87
#>
#> $convexity
#> [1] 73.7
#>
#> $price
#> [1] 104.01
```

### Z-spread

The Z-spread is the constant spread added to each zero rate on a benchmark curve that makes discounted cash flows equal the market price.

```r
# Benchmark zero curve
curve <- yc_curve(c(0.5, 1, 2, 5, 10), c(0.03, 0.035, 0.04, 0.042, 0.045))

# Bond trading below par: positive Z-spread
result <- yc_zspread(price = 95, coupon_rate = 0.04, maturity = 5,
                     curve = curve, frequency = 2)
result$zspread
#> [1] 0.0148   # 148 bps over the benchmark curve
```

### PCA decomposition

```r
# Simulate a time series of yield curves (200 days, 5 tenors)
set.seed(42)
n_days <- 200
tenors <- c(1, 2, 5, 10, 30)
base <- c(0.045, 0.043, 0.042, 0.040, 0.043)
level <- cumsum(rnorm(n_days, 0, 0.001))
curves <- matrix(NA, n_days, length(tenors))
for (i in seq_len(n_days)) curves[i, ] <- base + level[i]
colnames(curves) <- paste0(tenors, "Y")

pca <- yc_pca(curves)
pca
#> -- Yield Curve PCA --
#> * Components: 3
#> * PC1 (Level): 97.2% variance    <-- parallel shifts in the curve
#> * PC2 (Slope): 1.2% variance     <-- short vs long rates move apart
#> * PC3 (Curvature): 0.8% variance <-- belly of the curve moves independently
```

## Key concepts

A few things worth knowing if you're new to yield curves:

- **Zero rates** (also called spot rates) are the yields on zero-coupon bonds. Pay nothing until maturity, then pay face value. These are the building blocks.
- **Par rates** are the coupon rates at which a bond prices at par (100). These are what you see quoted as "the 10-year yield" in the news.
- **Forward rates** are the rates implied by the curve for a future period. The "5-year rate, 5 years forward" is the rate you could lock in today for a loan starting in 5 years.
- All rates in this package are **decimals**: 5% = `0.05`, 50 basis points = `0.005`.

## Functions

| Function | Description |
|----------|-------------|
| `yc_curve()` | Create a yield curve object from maturity-rate pairs |
| `yc_nelson_siegel()` | Fit a Nelson-Siegel (1987) model |
| `yc_svensson()` | Fit a Svensson (1994) model |
| `yc_cubic_spline()` | Fit a cubic spline |
| `yc_fit()` | Unified fitting interface |
| `yc_predict()` | Evaluate a fitted curve at new maturities |
| `yc_forward()` | Extract forward rates (instantaneous or forward-forward) |
| `yc_discount()` | Compute discount factors |
| `yc_duration()` | Compute duration and convexity |
| `yc_par_to_zero()` | Convert par rates to zero rates (bootstrap) |
| `yc_zero_to_par()` | Convert zero rates to par rates |
| `yc_interpolate()` | Interpolate between observed rates |
| `yc_pca()` | Principal component analysis of yield curves |
| `yc_carry()` | Carry and roll-down decomposition |
| `yc_bond_duration()` | Macaulay/modified duration and convexity for coupon bonds |
| `yc_zspread()` | Z-spread (zero-volatility spread) computation |
| `yc_key_rate_duration()` | Key rate durations with triangular bumps |
| `yc_slope()` | Spread measures (2s10s, butterfly, etc.) |
| `yc_level_slope_curvature()` | Level, slope, and curvature decomposition |

## Related packages

| Package | Description | CRAN |
|---------|-------------|------|
| [boe](https://github.com/charlescoverdale/boe) | Bank of England data (includes official yield curves) | [![CRAN](https://www.r-pkg.org/badges/version/boe)](https://cran.r-project.org/package=boe) |
| [fred](https://github.com/charlescoverdale/fred) | Federal Reserve Economic Data (includes Treasury rates) | [![CRAN](https://www.r-pkg.org/badges/version/fred)](https://cran.r-project.org/package=fred) |
| [readecb](https://github.com/charlescoverdale/readecb) | European Central Bank data (includes euro area yield curves) | [![CRAN](https://www.r-pkg.org/badges/version/readecb)](https://cran.r-project.org/package=readecb) |

r, r-package, yield-curve, fixed-income, nelson-siegel, svensson, term-structure, interest-rates, bond-math, finance
