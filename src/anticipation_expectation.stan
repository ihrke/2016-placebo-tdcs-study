// regression with Anticipated/Experienced as factor
data {
  int<lower=0> nsubj;
  int<lower=1,upper=3> dat[nsubj*4]; // first Anticipated/Experienced, first A then B
  real<lower=0,upper=1> question[nsubj*4]; // Anticipated=0; Experienced=1  
  real<lower=0,upper=1> condition[nsubj*4]; // A=0; B=1
}

parameters {
  // NOTE: beta[1] is fixed to zero because of identifiability (see DBDAE2,22)
  real free_beta0[2]; // intercept anticipation
  real free_beta1[2]; // effect of condition
  real free_beta2[2]; // effect of question
  real free_beta3[2]; // effect of condition x question
}
transformed parameters {
  vector[3] beta0;
  vector[3] beta1;
  vector[3] beta2;
  vector[3] beta3;

  beta0[1]<-free_beta0[1];
  beta0[2]<-0;
  beta0[3]<-free_beta0[2];

  beta1[1]<-free_beta1[1];
  beta1[2]<-0;
  beta1[3]<-free_beta1[2];
  
  beta2[1]<-free_beta2[1];
  beta2[2]<-0;
  beta2[3]<-free_beta2[2];

  beta3[1]<-free_beta3[1];
  beta3[2]<-0;
  beta3[3]<-free_beta3[2];

}

model {
  for( i in 1:(4*nsubj) ){
    dat[i] ~ categorical_logit( beta0+beta1*condition[i]+beta2*question[i]+beta3*condition[i]*question[i]  );
  }
}

generated quantities {
}