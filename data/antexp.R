# anticipation/expectation of improvement
fname=file.path("data","raw", "AntExp_n29.csv")

antexp<-read.table(fname, header=T, sep=";", as.is = T)[,1:9]
antexp[antexp=="na."]<-NA
antexp<-droplevels(antexp)

antexp <- within(antexp,{
       AAntDirection=factor(AAntDirection);
       AAntAmount=as.numeric(AAntAmount);
       AExpDirection=factor(AExpDirection);
       AExpAmount=as.numeric(AExpAmount);
       BAntDirection=factor(BAntDirection);
       BAntAmount=as.numeric(BAntAmount);
       BExpDirection=factor(BExpDirection);
       BExpAmount=as.numeric(BExpAmount);
       })

#summary(antexp)
