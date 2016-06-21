##
## anticipation/experienced improvements
##
library(ProjectTemplate)
load.project()
d<-antexp[complete.cases(antexp),]

d %>% select( AAntDirection, BAntDirection, AExpDirection,BExpDirection ) %>% 
  gather(variable, direction) %>% separate(variable, c("condition","question",'trash'),c(1,4)) %>%
  mutate(condition=plyr::revalue(condition, c("A"="LU", "B"="HU"))) %>%
  group_by(question,condition,direction) %>% summarize(n=n()) %>% mutate(perc=n/27.)
  


library(rstan)
# enabls --force for stallo etc.
options <- commandArgs(trailingOnly = TRUE)
if( "--force" %in% options)
  uncache.all()
bname<-tools::file_path_sans_ext(basename(this.file.name()))
mod.fname=sprintf("./src/%s.stan", bname)

n.chains=8
n.cores=1
n.iter=2000
n.warmup=1000

nsubj=dim(d)[1]
data=list(
  nsubj=nsubj,
  dat=c( as.numeric(ordered(d$AAntDirection, c("-1", "0", "1"))),
         as.numeric(ordered(d$BAntDirection, c("-1", "0", "1"))),
         as.numeric(ordered(d$AExpDirection, c("-1", "0", "1"))),
         as.numeric(ordered(d$BExpDirection, c("-1", "0", "1")))),
  #dat=c( as.numeric(d$AAntDirection), as.numeric(d$BAntDirection), 
  #       as.numeric(d$AExpDirection), as.numeric(d$BExpDirection)),
  condition=rep(rep( c(0,1), each=nsubj), 2),
  question=rep( c(0,1), each=2*nsubj)
)


mod <- stan(mod.fname, data = data, chains = 0)

fit = stan(fit=mod, data = data, chains = n.chains, iter = n.iter, warmup = n.warmup)#, init=initfct)
stop()
fit = stan(fit=mod, data = data, chains = n.chains, iter = 20000, warmup = 200)#, init=initfct)

ms=extract(fit, c("beta0", "beta1", "beta2", "beta3"))
ms2=do.call(cbind, ms)
colnames(ms2) <- c("beta0[1]","beta0[2]","beta0[3]",
                   "beta1[1]","beta1[2]","beta1[3]",
                   "beta2[1]","beta2[2]","beta2[3]",
                   "beta3[1]","beta3[2]","beta3[3]")
dotplot(ms2)

coefs<-cbind(mean=apply(ms2,2,mean),
             sd=apply(ms2,2,sd),
             lower=apply(ms2,2,function(x){hdi(x)[1]}),
             upper=apply(ms2,2,function(x){hdi(x)[2]}))
coefs
xtable::xtable(coefs)
beta0=ms[[1]]#[1:100,]
beta1=ms[[2]]#[1:100,]
beta2=ms[[3]]#[1:100,]
beta3=ms[[4]]#[1:100,]

pAntA=softmax(beta0)
colnames(pAntA) <- c("decline", "neutral", "improve")
pAntB=softmax(beta0+beta1)
colnames(pAntB) <- c("decline", "neutral", "improve")
dotplot(pAntA,pAntB)+xlim(0,1)

pExpA=softmax(beta0+beta2)
colnames(pExpA) <- c("decline", "neutral", "improve")
pExpB=softmax(beta0+beta1+beta2+beta3)
colnames(pExpB) <- c("decline", "neutral", "improve")
dotplot(pExpA,pExpB)+xlim(0,1)


## ternary plot of probability simplex
library(ggtern)
library(grid)

data.frame(cbind(rbind(pAntA,pAntB,pExpA,pExpB), condition=(rep(rep(c("LU", "HU"),each=dim(pExpA)[1]),2)),
                 question=(rep(c("Anticipated","Experienced"),each=2*dim(pExpA)[1])))) %>% 
  mutate(decline=as.numeric(as.character(decline)),
         neutral=as.numeric(as.character(neutral)),
         improve=as.numeric(as.character(improve))) %>%
ggtern(aes(decline,neutral,improve,color=condition))+
  #geom_point(colour='grey', alpha=0.2)+
  geom_density_tern()+theme_bw()+
  facet_wrap(~question)+
  #facet_grid(condition~question)+
#  theme(panel.margin.x = unit(6, "lines"))+ # more space between columns
  theme(axis.tern.title=element_blank()) # removes the labels from the corners



## try HPDregionplot
hdidf <- function(dat, prob=0.95){
  colnames(dat)<-c("L","T","R")
  xy=transform_tern_to_cart(data=data.frame(dat))
  #with(xy, plot(x,y, xlim=c(0,1),ylim=c(0,1)))
  e<-HPDregion(coda::mcmc(xy), prob=prob)
  #with(e[[1]], points(x,y, xlim=c(0,1),ylim=c(0,1), col='red'))
  getdf<-function(e){
    e2=data.frame(e)[,c("x","y")]
    names(e2)<-c("x","y")
    e3=transform_cart_to_tern(data=e2)
    names(e3) <- c("neutral", "decline", "improve")
    e3
  }
  if(length(prob)>1){
    r=lapply(e, getdf)
    r2=do.call(rbind, r)
    r<-cbind(prob=rep(prob, unlist(lapply(r, function(x){dim(x)[1]}))), r2)
  } else {
    r=cbind(prob=prob,getdf(e))
  }
  r
}
prob=c(.50, .80, 0.95)
r=lapply(list(pAntA,pAntB,pExpA,pExpB), function(x){hdidf(x,prob=prob)})
r2=do.call(rbind,r)
df=cbind(question=rep(c("Anticipated","Experienced"), c(dim(r[[1]])[1]+dim(r[[2]])[1], dim(r[[3]])[1]+dim(r[[4]])[1])), 
         condition=rep(c("LU","HU","LU","HU"), unlist(lapply(r,function(x){dim(x)[1]}))),
         r2)

means <- df %>% mutate(prob=(prob)) %>% group_by(question, condition) %>% summarise(decline=mean(decline),
                                                                                          neutral=mean(neutral),
                                                                                          improve=mean(improve))

df %>% mutate(prob=(prob)) %>% #filter(condition=="LU") %>%
  ggtern(aes(decline, neutral, improve, group=interaction(condition,prob), color=condition))+
    geom_path(size=1.5,alpha=.6)+theme_bw()+facet_wrap(~question)+geom_point(data=means, size=3)+
  theme(axis.tern.title=element_blank())+theme(panel.margin.x = unit(3, "lines"))



