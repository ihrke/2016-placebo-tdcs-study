library("ProjectTemplate")
load.project()


str(transfer)

chooseA <- transfer %>% mutate(Atrial=ifelse(symb1=="A"|symb2=="A",1,0)) %>%
  filter(Atrial>0) %>% group_by(Participant,condition) %>% summarise(chooseA=sum(choice=="A", na.rm=T)/n()) %>% data.frame
avoidB  <- transfer %>% mutate(Btrial=ifelse(symb1=="B"|symb2=="B",1,0)) %>%
  filter(Btrial>0) %>% group_by(Participant, condition) %>% summarise(avoidB=1-sum(choice=="B", na.rm=T)/n()) %>% data.frame

means <- merge(chooseA, avoidB) %>% group_by(condition) %>% summarise(chooseA_mean=mean(chooseA),
                                                             chooseA_se=sem(chooseA), 
                                                             avoidB_mean=mean(avoidB),
                                                             avoidB_se=sem(avoidB))
  

p1<-ggplot(means, aes(x=condition, fill=condition, y=chooseA_mean, ymin=chooseA_mean-chooseA_se, ymax=chooseA_mean+chooseA_se))+
  geom_bar(stat="identity")+geom_errorbar(width=.2)

p2<-ggplot(means, aes(x=condition, fill=condition, y=avoidB_mean, ymin=avoidB_mean-avoidB_se, ymax=avoidB_mean+avoidB_se))+
  geom_bar(stat="identity")+geom_errorbar(width=.2)

multiplot(p1,p2,cols=2)

summary(mod<-lmerTest::lmer(chooseA ~ as.numeric(condition)+(1|Participant), chooseA))

library(ez)
ezANOVA(chooseA,
        dv=chooseA,
        wid=Participant,
        within=.(condition))

ezANOVA(chooseA%>% mutate(condition=as.numeric(condition)),
        dv=chooseA,
        wid=Participant,
        within=.(condition))

ezANOVA(avoidB,
        dv=avoidB,
        wid=Participant,
        within=.(condition))



learn %>% group_by(Participant, condition) %>% summarise(RT=mean(RT, na.rm=T)) %>% data.frame %>%
  ezANOVA(dv=RT, wid=Participant,within = .(condition))

learn %>% group_by(Participant, condition) %>% summarise(RT=mean(RT, na.rm=T)) %>% group_by(condition) %>% summarize(mean(RT))
