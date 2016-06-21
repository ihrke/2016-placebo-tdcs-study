dpath<-file.path('data', 'raw', 'learning', 'B')
fnames<-list.files(dpath, pattern = "*.csv")

learn.B<-NULL
for(fname in fnames){
  d<-read.table(file.path(dpath, fname), header=T, sep=",") %>% 
    select(Participant, pair=Pair, condition=StimCondition, ACC=Response.corr, 
           RT=Response.rt, Fb1, Fb2) %>%
    mutate(Fb1=as.numeric(str_detect(Fb1, "posf")), 
           Fb2=as.numeric(str_detect(Fb2, "posf")),
           reward=ifelse(ACC>0, Fb1, Fb2), ACC=ifelse(is.na(RT), -1, ACC)) %>% select(-Fb1, -Fb2)
  learn.B<-rbind(learn.B, d)
}

## this is how I coded it in python:
#
#
# d=pd.read_csv(fname)#, sep='\t', index_col=False)
# sel=['Fb1', 'Fb2','trials.thisN', 'trials.thisTrialN', 'trials.thisRepN', 'Response.keys', 
#      'Response.corr', 'Response.rt', 'Pair']
# d=d[sel]
# d.columns=['Fb1', 'Fb2', 'trial', 'blocktrial','block', 'resp', 'acc', 'rt', 'pair']
# d['feedback']=[ d.Fb1[t] if d.acc[t]>0 else d.Fb2[t] for t in d.index]
# d['r']=np.array([1 if 'posf' in d.feedback[t] else 0 for t in d.index], dtype=np.int32)
# 
# # specify missing trials
# d.acc=np.array(d.acc, dtype=np.int32)
# d.acc[np.isnan(d.rt)]=-1
# d.r[np.isnan(d.rt)]=0
# 
# d['Pair_type']=d.pair.copy()
# d['pair']=d.pair.map({1:'AB', 2:'CD', 3:'EF'})
