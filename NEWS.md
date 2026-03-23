# yieldcurves 0.2.0

* Multi-start optimization for Nelson-Siegel and Svensson fitting. A grid
  search over tau values finds the best OLS starting point before local
  optimization, following BIS/ECB methodology. This reduces sensitivity to
  initial values and improves fit quality.
* Semi-annual coupon bootstrap: `yc_par_to_zero()` and `yc_zero_to_par()` now
  accept `frequency = 2` for semi-annual coupon bonds.
* New `yc_bond_duration()` computes Macaulay duration, modified duration, and
  convexity for coupon-bearing bonds (annual, semi-annual, or continuous
  compounding).
* New `yc_zspread()` computes the Z-spread (zero-volatility spread) for a bond
  given a benchmark zero curve.
* New `yc_key_rate_duration()` computes key rate durations using triangular
  bump profiles at specified tenors.

# yieldcurves 0.1.0

* Initial CRAN release.
* Nelson-Siegel (1987) and Svensson (1994) yield curve fitting with optional
  observation weights.
* Cubic spline interpolation via `stats::splinefun`.
* Forward rate extraction (analytical for NS/Svensson, numerical for splines).
* Discount factor computation with continuous, annual, and semi-annual
  compounding.
* Duration and convexity for zero-coupon bonds.
* Par-to-zero and zero-to-par rate conversions via bootstrap stripping.
* Principal component decomposition of yield curve time series.
* Carry and roll-down analysis.
* Slope measures (2s10s, 2s30s, butterfly) and level-slope-curvature
  decomposition.
