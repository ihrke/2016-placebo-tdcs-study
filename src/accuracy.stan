data {
  int<lower=0> ntrials;
  int<lower=0> nsubj;
  int<lower=0> n;
  int<lower=0,upper=1> ACC[n];
  int<lower=0,upper=nsubj> subj[n];
  int<lower=1, upper=ntrials> trial[n];
  int<lower=0,upper=1> conditionA[n];
  int<lower=0,upper=1> conditionB[n];
  int<lower=1,upper=3> pair[n];
}

parameters {
  real a[nsubj]; // intercept
  real btrial; // trial
  real bpair; // pair
  real bcondA; // conditionA
  real bcondB; // conditionB
  
  real mu_a; // group-level
  real<lower=0> sig_a; 
}
model {
  a ~ normal( mu_a, sig_a );
  //ACC ~ bernoulli_logit( a[subj] + btrial*trial + bpair*trial + bcondA*conditionA + bcondB*conditionB );
  for( i in 1:n){
    ACC[i] ~ bernoulli_logit( a[subj[i]] + btrial*trial[i] + bpair*pair[i] + bcondA*conditionA[i] + bcondB*conditionB[i] );
  }
}

generated quantities {
}