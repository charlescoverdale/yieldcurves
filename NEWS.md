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
