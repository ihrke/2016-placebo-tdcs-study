lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F)
  attributes(p) <- NULL
  return(p)
}
coef.p.lm <- function(mod){
  if (class(mod) != "lm") stop("Not an object of class 'lm' ")
  coeffs=summary(mod)$coefficients
  coeffs[,"Pr(>|t|)"]
}

simulate_correlated_data <- function(nsim, mean1, mean2, std1, std2, r){
  means=c(mean1,mean2)
  sds=c(std1, std2)
  sigma=matrix(c(sds[1], r*sqrt(std1*std2), r*sqrt(std1*std2), std2), ncol=2, byrow=T)
  sim=mvtnorm::rmvnorm(nsim, mean=means, sigma=sigma)
  return( data.frame(x=sim[,1], y=sim[,2]))
  
}

lmplot <-function(mod, nsim=100, slope_coef=2){
  a=(coef(mod))[1]
  b=coef(mod)[slope_coef]
  
  plot(mod$model[,slope_coef], mod$model[,1], 'p')
  sims=arm::sim(mod, n.sims=nsim)
  for(i in 1:nsim){
    abline(coef(sims)[i,1], coef(sims)[i,slope_coef], col='grey')
  }
  abline(a,b, col='red')
}

missing.table <- function(df){
  r=data.frame(t(data.frame(lapply(df, function(x){sum(is.na(x))}))))
  names(r)[1]="n.missing"
  r$unique.missing=0
  r$n=nrow(df)
  for( i in 1:ncol(df)){
    ix=which(is.na(df[,i]))
    if(length(ix)!=0){
      nmiss=apply(apply(df[ix,], 1, is.na), 2, sum)
      r$unique.missing[i]=sum(nmiss==1)
    }
  }
  r
}

effect.size.f2 <- function(mod){
  vars=names(mod$model[-1])
  ss=anova(mod)[['Sum Sq']]
  f2=(ss/sum(ss))[1:length(vars)]
  names(f2)<-vars
  f2
}
