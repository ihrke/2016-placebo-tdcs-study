## this scripts exports the aggregated and preprocessed data
# (after running the scripts in data/ and munge/) 
# for easier access 
# - data is put into data/export/
# - data is exported in two formats
#     1. as a single .RData file containing all relevant data.frames
#     2. as separate .csv files for compatibility with other analysis software
#
library(ProjectTemplate)
load.project()


## export as .RData
# name of the .RData file to which the data is exported
fname="data/export/placebo_tdcs_study.RData"
save(antexp, arousal, learn, transfer, file=fname)


## export as .csv files
fname="data/export/placebo_tdcs_antexp.csv"
write.table(antexp, file=fname, sep=",", row.names=F)

fname="data/export/placebo_tdcs_arousal.csv"
write.table(arousal, file=fname, sep=",", row.names=F)

fname="data/export/placebo_tdcs_learn.csv"
write.table(learn, file=fname, sep=",", row.names=F)

fname="data/export/placebo_tdcs_transfer.csv"
write.table(transfer, file=fname, sep=",", row.names=F)

