##
## descriptive plots for paper
##
library(ProjectTemplate)
load.project()


## ACC
learn %>% filter(ACC>=0) %>% group_by(Participant, condition, pair) %>% 
  summarise(ACC=mean(ACC),RT=mean(RT)) %>% group_by(condition,pair) %>% 
  summarize(mACC=mean(ACC),semACC=sem(ACC), mRT=mean(RT), semRT=sem(RT)) %>% ungroup %>%
  mutate(condition=plyr::revalue(condition, c("N"="baseline", "A"="LU", "B"="HU"))) %>%
  gather(variable, mean.value, mACC, mRT,-pair,-condition) %>%
  mutate(variable=plyr::revalue(variable, c("mACC"="accuracy","mRT"="RT")), sem.value=ifelse(variable=="accuracy",semACC,semRT)) %>%
  ggplot(aes(x=pair,y=mean.value,group=condition,fill=condition,ymin=mean.value-sem.value,ymax=mean.value+sem.value))+
  geom_bar(stat='identity',position=position_dodge())+
  geom_errorbar(width=0.3,position=position_dodge(0.9))+
  ylab('')+
  xlab('stimulus pair')+
  facet_wrap(~variable,scales = 'free')+
  ylim(0,1)+theme_bw()+theme(panel.margin.x = unit(2.5, "lines"))+
  scale_fill_manual(values = c("grey", rev(gg_color_hue(2))))



## ACC difference barplot
learn %>% filter(ACC>=0) %>% group_by(Participant, condition, pair) %>% 
  summarise(ACC=mean(ACC)) %>% group_by(pair) %>% spread(condition, ACC) %>%
  mutate(dA=N-A, dB=N-B) %>% gather(condition, ACC, dA, dB) %>% group_by(condition, pair) %>%
  summarize(mACC=mean(ACC),semACC=sem(ACC)) %>% ungroup %>%
  mutate(condition=plyr::revalue(condition, c("dA"="LU", "dB"="HU"))) %>%
  ggplot(aes(x=pair,y=mACC,group=condition,fill=condition,ymin=mACC-semACC,ymax=mACC+semACC))+
  geom_bar(stat='identity',position=position_dodge())+
  geom_errorbar(width=0.3,position=position_dodge(0.9))+
  ylab('')+  scale_fill_manual(values = c("grey", rev(gg_color_hue(2))))

