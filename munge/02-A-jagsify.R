jagsify <- function(d){
  ACCN    <- d %>% filter(condition=="N") %>% select(Participant, ACC) %>% unstack(form="ACC~Participant") %>% as.matrix
  ACCA    <- d %>% filter(condition=="A") %>% select(Participant, ACC) %>% unstack(form="ACC~Participant") %>% as.matrix
  ACCB    <- d %>% filter(condition=="B") %>% select(Participant, ACC) %>% unstack(form="ACC~Participant") %>% as.matrix  
  
  pairN   <- d %>% filter(condition=="N") %>% select(Participant, pair) %>% mutate(pair=as.numeric(pair)) %>% unstack(form="pair~Participant") %>% as.matrix
  pairA   <- d %>% filter(condition=="A") %>% select(Participant, pair) %>% mutate(pair=as.numeric(pair)) %>% unstack(form="pair~Participant") %>% as.matrix
  pairB   <- d %>% filter(condition=="B") %>% select(Participant, pair) %>% mutate(pair=as.numeric(pair)) %>% unstack(form="pair~Participant") %>% as.matrix  
  
  rewardN <- d %>% filter(condition=="N") %>% select(Participant, reward) %>% unstack(form="reward~Participant") %>% as.matrix
  rewardA <- d %>% filter(condition=="A") %>% select(Participant, reward) %>% unstack(form="reward~Participant") %>% as.matrix  
  rewardB <- d %>% filter(condition=="B") %>% select(Participant, reward) %>% unstack(form="reward~Participant") %>% as.matrix  
  
  nsubj=ncol(ACCN)
  data=list(nsubj=nsubj, 
            ACCN=ACCN, ACCA=ACCA, ACCB=ACCB,
            pairN=pairN, pairA=pairA, pairB=pairB,
            rewardN=rewardN, rewardA=rewardA, rewardB=rewardB )
  # check that columns are ordered in the same way
  stopifnot( all(colnames(ACCN)==colnames(pairN)) & all(colnames(ACCN)==colnames(rewardN)))
  data
}

learn.jags <- jagsify(learn)

