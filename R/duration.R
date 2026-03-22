#' Duration and Convexity
#'
#' Compute Macaulay duration, modified duration, and convexity for
#' zero-coupon bonds at each maturity on the curve.
#'
#' @param curve A `yc_curve` object.
#' @param maturities Optional numeric vector of maturities. If NULL,
#'   uses the curve's own maturities.
#' @param compounding Character. Compounding convention: `"continuous"`
#'   (default), `"annual"`, or `"semi_annual"`.
#'
#' @return A data frame with columns `maturity`, `macaulay_duration`,
#'   `modified_duration`, and `convexity`.
#'
#' @export
#' @examples
#' maturities <- c(0.25, 1, 2, 5, 10, 30)
#' rates <- c(0.050, 0.048, 0.045, 0.042, 0.040, 0.043)
#' fit <- yc_nelson_siegel(maturities, rates)
#' yc_duration(fit)
yc_duration <- function(curve, maturities = NULL,
                         compounding = c("continuous", "annual",
                                         "semi_annual")) {
  validate_yc_curve(curve)
  compounding <- match.arg(compounding)

  if (is.null(maturities)) {
    maturities <- curve$maturities
  } else {
    validate_maturities(maturities)
  }

  rates <- yc_predict(curve, maturities)$rate

  if (compounding == "continuous") {
    # For continuous compounding: Macaulay duration = maturity (zero-coupon)
    # Modified duration = maturity (same as Macaulay for continuous)
    # Convexity = maturity^2
    mac_dur <- maturities
    mod_dur <- maturities
    convexity <- maturities^2
  } else if (compounding == "annual") {
    # Macaulay duration for zero-coupon = maturity
    # Modified duration = maturity / (1 + r)
    # Convexity = maturity * (maturity + 1) / (1 + r)^2
    mac_dur <- maturities
    mod_dur <- maturities / (1 + rates)
    convexity <- maturities * (maturities + 1) / (1 + rates)^2
  } else {
    # Semi-annual: Modified duration = maturity / (1 + r/2)
    # Convexity = maturity * (maturity + 0.5) / (1 + r/2)^2
    mac_dur <- maturities
    mod_dur <- maturities / (1 + rates / 2)
    convexity <- maturities * (maturities + 0.5) / (1 + rates / 2)^2
  }

  data.frame(
    maturity = maturities,
    macaulay_duration = mac_dur,
    modified_duration = mod_dur,
    convexity = convexity,
    stringsAsFactors = FALSE
  )
}
