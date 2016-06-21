#
# logistic regression model with random intercepts per subject
#
library("ProjectTemplate")
load.project()
library(rstan)

# enabls --force for stallo etc.
options <- commandArgs(trailingOnly = TRUE)
if( "--force" %in% options)
  uncache.all()
bname<-tools::file_path_sans_ext(basename(this.file.name()))
mod.fname=sprintf("./src/%s.stan", bname)

n.chains=8
n.cores=8
n.iter=1000
n.warmup=500

d<-learn %>% group_by(Participant, condition, pair) %>% mutate(trial=1:n(), ztrial=scale(trial)) %>% ungroup %>%
  filter(ACC>=0) %>% mutate(subj=as.numeric(Participant)) %>% as.data.frame

#dacc=d %>% group_by(Participant, condition, pair) %>% summarize(ACC=mean(ACC))
#summary(lm(ACC ~ condition + pair, data=dacc))

nsubj=length(unique(d$Participant))
ntrials=max(d$trial)
data=list(
  nsubj=nsubj,
  ntrials=ntrials,
  n=dim(d)[1],
  ACC=d$ACC,
  subj=d$subj,
  trial=d$trial,
  conditionA=ifelse(d$condition=="A", 1, 0),
  conditionB=ifelse(d$condition=="B", 1, 0),
  pair=d$pair
)
#stop()  
if(is.cached.var("fit")){
  printf("WARNING: loading variables from cache\n")
  fit=load.cache.var("fit")
} else {
  mod <- stan(mod.fname, data = data, chains = 0)
  start.time = proc.time()

  library(rstanmulticore)
  fit = pstan(fit = mod, data = data, chains = n.chains, iter = n.iter, warmup = n.warmup)

  tellmedone()
  end.time = proc.time()
  show("Time taken for sampling")
  show(end.time-start.time)
  
  cache.var('fit')
}

print(fit)  
print("Plotting...")
pdf(file=file.path('graphs', sprintf("%s.pdf", bname)))
plot(fit)
traceplot(fit)
dev.off()

m <- as.matrix(fit)
vars=colnames(m)

m2 <- m[,!str_detect(vars, '(a\\[)|(lp__)') ]
dotplot(m2)
m2.summ<-cbind(mean=apply(m2,2,mean), sd=apply(m2,2,sd), lower=apply(m2,2,hdi)[1,],
      upper=apply(m2,2,hdi)[2,])
xtable::xtable(m2.summ, digits=3)


#summary(mod <- glmer( ACC ~ scale(trial) + as.numeric(pair) + condition + (1|Participant), 
#                      data=d, family=binomial))

learn %>% group_by(Participant, condition) %>% mutate(trial=1:n(), ztrial=scale(trial)) %>% 
  filter(ACC>=0) %>% summarize(ACC=mean(ACC)) %>% group_by(condition) %>% summarize(mean(ACC), sem(ACC))

