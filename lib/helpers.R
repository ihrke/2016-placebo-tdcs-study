if("MASS" %in% loadedNamespaces()){
  select <- dplyr::select
}

install.common.packages <- function(){
  needed_pkgs=c('mvtnorm', 'ggplot2', 'dplyr', 'effects', 'pwr', 'arm', 'psych', 'car', "QuantPsyc",
                "rjags", "reshape2", "tidyr", 'mvtnorm', 'truncnorm', 'Rcpp', 'ProjectTemplate')

  # Install CRAN packages (if not already installed)
  .inst <- needed_pkgs %in% installed.packages()
  if(length(needed_pkgs[!.inst]) > 0) install.packages(needed_pkgs[!.inst])

  # Load packages into session 
  #.tmp=lapply(needed_pkgs, require, character.only=TRUE)
}


printf <- function(s, ...){
  cat(sprintf(s, ...))
}

sem <- function(x){
  (sd(x)/sqrt(length(x)))
}

softmax <- function(x){
  if(is.null(dim(x))){
    dim(x) <- c(1,length(x))
  }
  r<-exp(x)/rowSums(exp(x))
  if(dim(x)[1]==1){
    r<-as.vector(r)
  }
  r
}
