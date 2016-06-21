# anticipation/expectation of improvement
fname=file.path("data","raw", "arousal.csv")

arousal<-read.table(fname, header=T, sep=",", as.is = T, na.strings = c("na"))[1:29,1:7]
arousal$Participant=factor(arousal$Participant)
