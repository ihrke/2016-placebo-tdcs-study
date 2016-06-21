dpath<-file.path('data', 'raw', 'transfer', 'N')
fnames<-list.files(dpath, pattern = "*.csv")

stim.new=c("A", "B", "C", "D", "E", "F")

transfer.N<-NULL
for(fname in fnames){
  d<-read.table(file.path(dpath, fname), header=T, sep=",")
  stim.old<-sort(levels(d$Symbol1))

  d<-d %>% 
    select(Participant=participant, RT=Response.rt, symb1=Symbol1, symb2=Symbol2, choice=Response.keys) %>%
    mutate(symb1=plyr::mapvalues(symb1, stim.old, stim.new),
           symb2=plyr::mapvalues(symb2, stim.old, stim.new),
           choice=factor(ifelse(choice=='f', as.character(symb1), ifelse(choice=='j', as.character(symb2), NA)))
    )
  
  transfer.N<-rbind(transfer.N, d)
}