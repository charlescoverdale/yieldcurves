# Package index

## Curve Fitting

Parametric and spline yield curve models

- [`yc_nelson_siegel()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_nelson_siegel.md)
  : Fit Nelson-Siegel Yield Curve
- [`yc_svensson()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_svensson.md)
  : Fit Svensson Yield Curve
- [`yc_cubic_spline()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_cubic_spline.md)
  : Fit Cubic Spline Yield Curve
- [`yc_fit()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_fit.md)
  : Fit a Yield Curve
- [`yc_predict()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_predict.md)
  : Predict Rates from a Fitted Yield Curve

## Curve Metrics

Level, slope, curvature, and forward rates

- [`yc_curve()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_curve.md)
  : Create a Yield Curve Object
- [`yc_forward()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_forward.md)
  : Extract Forward Rates
- [`yc_slope()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_slope.md)
  : Yield Curve Slope Measures
- [`yc_level_slope_curvature()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_level_slope_curvature.md)
  : Extract Level, Slope, and Curvature Factors
- [`yc_interpolate()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_interpolate.md)
  : Interpolate Yield Curve

## Risk and Returns

Duration, carry, rolldown, and z-spread

- [`yc_duration()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_duration.md)
  : Duration and Convexity
- [`yc_bond_duration()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_bond_duration.md)
  : Coupon Bond Duration and Convexity
- [`yc_key_rate_duration()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_key_rate_duration.md)
  : Key Rate Durations
- [`yc_carry()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_carry.md)
  : Carry and Roll-Down Analysis
- [`yc_zspread()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_zspread.md)
  : Z-Spread

## Decomposition

PCA and zero/par conversions

- [`yc_pca()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_pca.md)
  : Principal Component Analysis of Yield Curves
- [`yc_par_to_zero()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_par_to_zero.md)
  : Convert Par Rates to Zero Rates
- [`yc_zero_to_par()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_zero_to_par.md)
  : Convert Zero Rates to Par Rates
- [`yc_discount()`](https://charlescoverdale.github.io/yieldcurves/reference/yc_discount.md)
  : Compute Discount Factors

## Package

- [`yieldcurves`](https://charlescoverdale.github.io/yieldcurves/reference/yieldcurves-package.md)
  [`yieldcurves-package`](https://charlescoverdale.github.io/yieldcurves/reference/yieldcurves-package.md)
  : yieldcurves: Yield Curve Fitting, Analysis, and Decomposition

## S3 Methods

Plot, print, and summary methods for curve objects

- [`plot(`*`<yc_curve>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/plot.yc_curve.md)
  : Plot Method for Yield Curve Objects
- [`plot(`*`<yc_pca>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/plot.yc_pca.md)
  : Plot Method for Yield Curve PCA Objects
- [`print(`*`<yc_curve>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/print.yc_curve.md)
  : Print Method for Yield Curve Objects
- [`print(`*`<yc_pca>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/print.yc_pca.md)
  : Print Method for Yield Curve PCA Objects
- [`summary(`*`<yc_curve>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/summary.yc_curve.md)
  : Summary Method for Yield Curve Objects
- [`summary(`*`<yc_pca>`*`)`](https://charlescoverdale.github.io/yieldcurves/reference/summary.yc_pca.md)
  : Summary Method for Yield Curve PCA Objects
