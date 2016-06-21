
############################################################################
#         R FUNCTIONS FOR THE INVERSE GAMMA DISTRIBUTION
#
#         (by Jeffrey S. Rosenthal, probability.ca, 2007)
# 
# The base package of the statistical software R does not seem to include
# built-in functions for the inverse gamma distribution.  So, I provide
# them here, using trivial modifications of the corresponding
# built-in functions for the gamma distribution.  (Released under GPL.)
############################################################################

# dinvgamma: density function of the inverse-gamma distribution
dinvgamma = function(x, shape = 1, rate = 1, scale = 1/rate, log = FALSE) {
  # return( rate^shape / gamma(shape) * x^(-shape-1) * exp(-rate/x) )
  logval = shape*log(rate) - lgamma(shape) - (shape+1)*log(x) - rate/x
  if (log)
    return(logval)
  else
    return(exp(logval))
}

# pinvgamma: cumulative distribution function of the inverse-gamma distribution
pinvgamma = function(q, shape = 1, rate = 1, scale = 1/rate,
                     lower.tail = TRUE, log.p = FALSE) {
  return( pgamma(1/q,shape,rate,scale,!lower.tail,log.p) )
}

# qinvgamma: quantile function of the inverse-gamma distribution
qinvgamma = function(p, shape = 1, rate = 1, scale = 1/rate,
                     lower.tail = TRUE, log.p = FALSE) {
  return( 1 / qgamma(p,shape,rate,scale,!lower.tail,log.p) )
}

# rinvgamma: sample a vector of inverse-gamma random variables
rinvgamma = function(n, shape = 1, rate = 1, scale = 1/rate) {
  return( 1 / rgamma(n,shape,rate,scale) )
}
