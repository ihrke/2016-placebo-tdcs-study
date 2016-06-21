## http://stackoverflow.com/a/15373917/972791
this.file.name <- function() {
  cmdArgs <- commandArgs(trailingOnly = FALSE)
  needle <- "--file="
  match <- grep(needle, cmdArgs)
  if (length(match) > 0) {
    # Rscript
    return(normalizePath(sub(needle, "", cmdArgs[match])))
  } else {
    # 'source'd via R console
    return(normalizePath(sys.frames()[[1]]$ofile))
  }
}


options(rpushbullet.key="VHRc5B9jxotNsg1cFKjNacRscTsjYt97")
tryCatch( 
  library(RPushbullet),
  error=function(e){})
          

tellmedone <- function(msg=NULL){
  tryCatch(
    if(!is.null(msg)){
      pbPost(msg, type="note")
    } else {
      pbPost(basename(this.file.name()), type="note")
    },
    error=function(e){ print("did not push message") })
}