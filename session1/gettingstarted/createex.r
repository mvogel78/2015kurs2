### read in data
x <- data.frame(id=LETTERS[1:10],
                date=Sys.Date()-101:110,
                score=rnorm(10,mean=100,sd=10))

write.table(x,"session1data/datatable1.txt",sep="|",row.names=F,dec=",")

x <- data.frame(id=sample(LETTERS[1:15],10),
                date=Sys.Date()-1:10,
                score=rnorm(10,mean=100,sd=10))

write.table(x,"session1data/datatable2.txt",sep="\t",row.names=F,dec=".")


persdat <- read.table("session1data/subjectdemographics.txt",
                      sep="\t",
                      header=T)

persdat$Subject <- paste0("PRE",sprintf("%03d",persdat$Subject))

write.table(persdat,"session1data/personendaten.txt",sep="\t",row.names=F)

