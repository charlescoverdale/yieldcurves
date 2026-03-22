# yieldcurves

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**Yield curve fitting, analysis, and decomposition for R.**

## What is a yield curve?

A yield curve plots the relationship between interest rates and the time to maturity of debt instruments. It is one of the most important objects in finance — central banks, bond traders, and macro researchers all use yield curves to understand market expectations about future interest rates, inflation, and economic growth.

The most common yield curve models are Nelson-Siegel (1987) and Svensson (1994), which decompose the curve into interpretable factors: level, slope, and curvature. These parsimonious models are used by central banks worldwide (the BIS surveys show over 20 central banks use Nelson-Siegel or Svensson for their official yield curve estimates).

`yieldcurves` provides a complete toolkit for fitting, analysing, and decomposing yield curves in R. It is a pure computation package — it does not download data. You supply two numeric vectors (maturities in years and rates as decimals) and the package does the rest.

## Where do I get yield data?

`yieldcurves` is a pure computation package — it does not download data itself. You bring two numeric vectors:

- **maturities**: time to maturity in years (e.g., `c(0.25, 1, 2, 5, 10, 30)`)
- **rates**: yields as decimals (e.g., `c(0.052, 0.048, 0.045, 0.042, 0.040, 0.043)`)

Here are the main sources of government bond yield data and how to get them into R:

| Country | Source | Free? | R package | FRED series codes |
|---------|--------|-------|-----------|-------------------|
| US | US Treasury / FRED | Yes | [fred](https://cran.r-project.org/package=fred) | DGS1MO, DGS3MO, DGS6MO, DGS1, DGS2, DGS3, DGS5, DGS7, DGS10, DGS20, DGS30 |
| UK | Bank of England | Yes | [boe](https://cran.r-project.org/package=boe) | `boe_yield_curve()` |
| Euro area | European Central Bank | Yes | [readecb](https://cran.r-project.org/package=readecb) | `ecb_yield_curve()` |
| Japan | Ministry of Finance | Yes | Download CSV from mof.go.jp | — |
| Australia | RBA | Yes | Download CSV from rba.gov.au | — |
| Canada | Bank of Canada | Yes | — | DGS series on FRED |
| Any | Bloomberg / Refinitiv | Paid | Rblpapi / refinitiv | — |

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
```

## How does this compare to existing packages?

| Feature | yieldcurves | YieldCurve | termstrc |
|---------|-------------|------------|----------|
| Nelson-Siegel fitting | ✅ | ✅ | ✅ |
| Svensson fitting | ✅ | ✅ | ✅ |
| Cubic spline | ✅ | ❌ | ✅ |
| Weighted fitting | ✅ | ❌ | ❌ |
| Forward rates (analytical) | ✅ | ❌ | ✅ |
| Discount factors | ✅ | ❌ | ✅ |
| Duration and convexity | ✅ | ❌ | ❌ |
| Par/zero conversions | ✅ | ❌ | ✅ |
| PCA decomposition | ✅ | ❌ | ❌ |
| Carry and roll-down | ✅ | ❌ | ❌ |
| Slope measures | ✅ | ❌ | ❌ |
| Works with plain vectors | ✅ | ❌ (needs xts/zoo) | ❌ |
| Base R graphics | ✅ | ✅ | ❌ |
| Last updated | 2026 | 2022 | 2015 |

## Installation

Install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("charlescoverdale/yieldcurves")
```

## Examples

### Fit a Nelson-Siegel curve

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

plot(fit)
```

### Extract forward rates and discount factors

```r
yc_forward(fit, maturities = c(1, 5, 10))
#>   maturity forward_rate
#> 1        1       0.0468
#> 2        5       0.0393
#> 3       10       0.0413

yc_discount(fit, maturities = c(1, 5, 10, 30))
#>   maturity discount_factor
#> 1        1          0.9530
#> 2        5          0.8103
#> 3       10          0.6619
#> 4       30          0.2817
```

### Carry and roll-down analysis

```r
yc_carry(fit, maturities = c(2, 5, 10, 30))
#>   maturity     carry   rolldown      total
#> 1        2  0.000170  0.005143  0.005313
#> 2        5  0.000013  0.004478  0.004491
#> 3       10 -0.000059  0.003260  0.003201
#> 4       30  0.000033 -0.001507 -0.001474
```

### PCA decomposition

```r
# Simulate a time series of yield curves
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
#> * PC1 (Level): 97.2% variance
#> * PC2 (Slope): 1.2% variance
#> * PC3 (Curvature): 0.8% variance
```

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
| `yc_slope()` | Spread measures (2s10s, butterfly, etc.) |
| `yc_level_slope_curvature()` | Level, slope, and curvature decomposition |

## Related packages

| Package | Description | CRAN |
|---------|-------------|------|
| [boe](https://github.com/charlescoverdale/boe) | Bank of England data (includes official yield curves) | [![CRAN](https://www.r-pkg.org/badges/version/boe)](https://cran.r-project.org/package=boe) |
| [fred](https://github.com/charlescoverdale/fred) | Federal Reserve Economic Data (includes Treasury rates) | [![CRAN](https://www.r-pkg.org/badges/version/fred)](https://cran.r-project.org/package=fred) |
| [readecb](https://github.com/charlescoverdale/readecb) | European Central Bank data (includes euro area yield curves) | [![CRAN](https://www.r-pkg.org/badges/version/readecb)](https://cran.r-project.org/package=readecb) |

r, r-package, yield-curve, fixed-income, nelson-siegel, svensson, term-structure, interest-rates, bond-math, finance
