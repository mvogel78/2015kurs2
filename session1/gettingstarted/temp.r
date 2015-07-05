directories <- paste("data",dir("data",pattern = "[^z]$"),sep="/")

lapply(directories,function(x) dir(x))

all.files <- lapply(directories, function(x) { read.files(filedir = x,skip=0) } )

tt <- read.table("data/pretest/pre_001.txt",sep="\t",skip=0,fill=T,header = T)
