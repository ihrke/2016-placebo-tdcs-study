select<-dplyr::select
learn <- rbind( learn.N, learn.A, learn.B)
transfer <- rbind( cbind(transfer.N, condition="N"), 
                   cbind(transfer.A, condition="A"),
                   cbind(transfer.B, condition="B"))
