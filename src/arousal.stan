// random intercept model
data {
  int<lower=0> n;
  int<lower=0> nsubj;
  int<lower=1,upper=nsubj> subj[n];
  real<lower=1,upper=10> arousal[n]; // BL_before,BL_after,A_before,A_after,B_before,B_after
  real<lower=0,upper=1> conditionA[n]; // BL=0; B=0; A=1;
  real<lower=0,upper=1> conditionB[n]; // BL=0; B=1; A=0;
  real<lower=0,upper=1> timeAfter[n]; // before=0; after=1 
  
}

parameters {
  real mu0;
  real<lower=0> sigma0;
  vector[nsubj] beta0;
  real beta1;
  real beta2;
  real beta3;
  real beta4;
  real beta5;
  real<lower=0> sigma;
}

model {
  for( i in 1:nsubj){
    beta0[i] ~ normal(mu0, sigma0);
  }
  for( i in 1:n ){
    arousal[i] ~ normal( beta0[subj[i]]+beta1*conditionA[i]+beta2*conditionB[i]+beta3*timeAfter[i]
                         + beta4*conditionA[i]*timeAfter[i]+beta5*conditionB[i]*timeAfter[i], sigma);
  }
}

generated quantities {
}