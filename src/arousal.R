##
## subjective arousal data
##
library(ProjectTemplate)
load.project()

arousal.long <- arousal %>% gather(condition,arousal,-Participant) %>% 
  separate(condition, into=c("condition","time"),  sep="_") %>%
  mutate(condition=relevel(factor(condition), ref="BL"),
         time=relevel(factor(time), ref="before"))

arousal.long %>% ggplot(aes(x=time, y=arousal, color=condition))+geom_boxplot()

library(lmerTest)
summary(mod1<-lmer(arousal ~ condition*time+(1|Participant), arousal.long))
summary(mod2<-lmer(arousal ~ condition+time+(1|Participant), arousal.long))
anova(mod1,mod2)


##+++++++++++ STAN
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


d <- arousal.long[complete.cases(arousal.long),]
nsubj <- length(levels(d$Participant))

data=list(
  n=dim(d)[1],
  nsubj=nsubj,
  subj=as.numeric(d$Participant),
  arousal=d$arousal,
  conditionA=as.numeric(d$condition=='A'),
  conditionB=as.numeric(d$condition=='B'),
  timeAfter=as.numeric(d$time=="after")
)
mod <- stan(mod.fname, data = data, chains = 0)

fit = stan(fit=mod, data = data, chains = n.chains, iter = n.iter, warmup = n.warmup)#, init=initfct)

#shinystan::launch_shinystan(fit)

m <- as.matrix(fit)
vars=colnames(m)
m2 <- m[,!str_detect(vars, '(beta0\\[)|(lp__)') ]
dotplot(m2)

means <- cbind(mean=apply(m2, 2, mean),
               sd=apply(m2, 2, sd),
               lower=apply(m2,2,hdi)[1,],
               upper=apply(m2,2,hdi)[2,])
xtable::xtable(means)
