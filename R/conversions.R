#' Convert Par Rates to Zero Rates
#'
#' Bootstrap zero (spot) rates from par (coupon) rates using iterative
#' stripping. Assumes annual coupon payments and annual compounding.
#'
#' @param maturities Numeric vector of maturities in years (must be
#'   positive integers or half-years).
#' @param par_rates Numeric vector of par rates as decimals.
#'
#' @return A data frame with columns `maturity` and `zero_rate`.
#'
#' @export
#' @examples
#' maturities <- c(1, 2, 3, 5, 10)
#' par_rates <- c(0.040, 0.042, 0.043, 0.044, 0.045)
#' yc_par_to_zero(maturities, par_rates)
yc_par_to_zero <- function(maturities, par_rates) {
  validate_maturities(maturities)
  validate_rates(par_rates, length(maturities), "par_rates")

  # Sort by maturity
  ord <- order(maturities)
  maturities <- maturities[ord]
  par_rates <- par_rates[ord]

  if (any(maturities != floor(maturities) & maturities > 1)) {
    cli_warn("Non-integer maturities > 1 may produce inaccurate results. The bootstrap assumes annual coupon bonds with integer coupon dates.")
  }

  n <- length(maturities)
  zero_rates <- numeric(n)

  # First maturity: zero = par

  zero_rates[1] <- par_rates[1]

  for (i in seq_len(n)[-1]) {
    m <- maturities[i]
    c_rate <- par_rates[i]

    # Sum of PV of coupons at earlier maturities
    # Need to interpolate zero rates at integer coupon dates
    coupon_dates <- seq(1, floor(m))
    if (length(coupon_dates) == 0 || max(coupon_dates) < m) {
      # For maturities <= 1, zero = par
      zero_rates[i] <- par_rates[i]
      next
    }

    # Interpolate zero rates at coupon dates from already-computed zeros
    if (i == 2) {
      z_interp <- approx(maturities[1:i], zero_rates[1:i],
                          xout = coupon_dates[-length(coupon_dates)],
                          rule = 2)$y
    } else {
      z_interp <- approx(maturities[1:(i - 1)], zero_rates[1:(i - 1)],
                          xout = coupon_dates[-length(coupon_dates)],
                          rule = 2)$y
    }

    # PV of intermediate coupons
    if (length(coupon_dates) > 1) {
      pv_coupons <- sum(c_rate / (1 + z_interp)^coupon_dates[-length(coupon_dates)])
    } else {
      pv_coupons <- 0
    }

    # Solve for zero rate at final maturity
    # 1 = pv_coupons + (1 + c_rate) / (1 + z_m)^m
    pv_final <- 1 - pv_coupons
    zero_rates[i] <- (((1 + c_rate) / pv_final)^(1 / m)) - 1
  }

  data.frame(
    maturity = maturities,
    zero_rate = zero_rates,
    stringsAsFactors = FALSE
  )
}

#' Convert Zero Rates to Par Rates
#'
#' Compute par (coupon) rates from zero (spot) rates. The par rate for
#' maturity T is the coupon rate that makes a bond price equal to par.
#'
#' @param maturities Numeric vector of maturities in years.
#' @param zero_rates Numeric vector of zero rates as decimals.
#'
#' @return A data frame with columns `maturity` and `par_rate`.
#'
#' @export
#' @examples
#' maturities <- c(1, 2, 3, 5, 10)
#' zero_rates <- c(0.040, 0.042, 0.043, 0.044, 0.045)
#' yc_zero_to_par(maturities, zero_rates)
yc_zero_to_par <- function(maturities, zero_rates) {
  validate_maturities(maturities)
  validate_rates(zero_rates, length(maturities), "zero_rates")

  ord <- order(maturities)
  maturities <- maturities[ord]
  zero_rates <- zero_rates[ord]

  if (any(maturities != floor(maturities) & maturities > 1)) {
    cli_warn("Non-integer maturities > 1 may produce inaccurate results. The par rate formula assumes annual coupon bonds with integer coupon dates.")
  }

  n <- length(maturities)
  par_rates <- numeric(n)

  for (i in seq_len(n)) {
    m <- maturities[i]
    coupon_dates <- seq(1, floor(m))

    if (length(coupon_dates) <= 1) {
      # For maturities <= 1, par = zero
      par_rates[i] <- zero_rates[i]
      next
    }

    # Interpolate zero rates at all coupon dates
    z_at_coupons <- approx(maturities[1:i], zero_rates[1:i],
                            xout = coupon_dates, rule = 2)$y

    # Discount factors at coupon dates
    df <- (1 + z_at_coupons)^(-coupon_dates)

    # Par rate = (1 - df_T) / sum(df)
    par_rates[i] <- (1 - df[length(df)]) / sum(df)
  }

  data.frame(
    maturity = maturities,
    par_rate = par_rates,
    stringsAsFactors = FALSE
  )
}
