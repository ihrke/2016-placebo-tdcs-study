mean.dbeta <- function( alpha, beta ){
  alpha/(alpha+beta)
}
var.dbeta <- function( alpha, beta ){
  (alpha*beta)/(( (alpha+beta)**2)*(alpha+beta+1))
}
mean.dgamma <- function( alpha, beta ){
  alpha/beta
}
var.dgamma <- function( alpha, beta ){
  alpha/(beta**2)
}


posterior.mode <- function(s){ 
  if( class(s)=="mcmc.list"){
    s=coda::mcmc(do.call(rbind, s))
  }
  if( class(s)=="mcmc"){
    s=as.matrix(s)
  }
  
  apply(s, 2, function(x){modeest::mlv(x, method="HSM")$M})
}
hdi <- function(s){
  if( class(s)=="mcmc.list"){
    s=coda::mcmc(do.call(rbind, s))
  }
  if( class(s)=="matrix" | class(s)=="numeric"){
    s=coda::mcmc(s)
  }
  coda::HPDinterval(s)
}


## modified emdbook::HPDregionplot
HPDregion <- function (x, vars = 1:2, h, n = 50, lump = TRUE, prob = 0.95, ...) 
{
  parnames <- if (class(x) == "mcmc.list") 
    colnames(x[[1]])
  else colnames(x)
  if (is.character(vars)) {
    vars <- match(vars, parnames)
    if (any(is.na(vars))) 
      stop("some variable names do not match")
  }
  varnames <- parnames[vars]
  mult <- (class(x) == "mcmc.list" && !lump)
  if (mult) 
    stop("multiple chains without lumping not yet implemented")
  if (class(x) == "mcmc.list") {
    if (lump) 
      var1 <- c(sapply(x, function(z) z[, vars[1]]))
    else var1 <- lapply(x, function(z) z[, vars[1]])
  }
  else var1 <- x[, vars[1]]
  if (class(x) == "mcmc.list") {
    if (lump) 
      var2 <- c(sapply(x, function(z) z[, vars[2]]))
    else var2 <- lapply(x, function(z) z[, vars[2]])
  }
  else var2 <- x[, vars[2]]
  lims <- c(range(var1), range(var2))
  if (!mult) {
    post1 <- MASS::kde2d(var1, var2, n = n, h = h, lims = lims)
  }
  else {
    post1 = mapply(MASS::kde2d, var1, var2, MoreArgs = list(n = n, 
                                                      h = h, lims = lims))
  }
  dx <- diff(post1$x[1:2])
  dy <- diff(post1$y[1:2])
  sz <- sort(post1$z)
  c1 <- cumsum(sz) * dx * dy
  levels <- sapply(prob, function(x) {
    approx(c1, sz, xout = 1 - x)$y
  })
  contourLines(post1$x, post1$y, post1$z, levels = levels)
}