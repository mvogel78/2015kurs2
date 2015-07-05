require(dplyr)

## functions

read.file <- function(file,skip=0,verbose=T){
    if(verbose) print(file)
    tmp <- read.table(file,skip = skip,sep = "\t",header=T,na.strings = c(" +",""))
    tmp <- tmp[-1,]
    tmp <- lapply(tmp,function(x) {
        if( class(x) %in% c("character","factor") ){
            x <- factor(gsub(" ","",as.character(x)))
            return(x)}else{ return(x) }})
    tmp <- as.data.frame(tmp)
    tmp <- tmp[!(tmp$Event.Type %in% c("Pause","Resume")), ]
    erste <- min(which(!(tmp$Code==3 & !is.na(tmp$Code))))
    tmp <- tmp[-c(1:erste),]

    letzte <- max(which(tmp$Code==3 & !is.na(tmp$Code)))
    tmp <- tmp[-c(letzte:nrow(tmp)),]

    zeilen <- which(tmp$Event.Type %in% c("Response"))
    zeilen <- sort(unique(c(zeilen,zeilen-1)))
    zeilen <- zeilen[zeilen>0]
    tmp <- tmp[zeilen,]
    
    responses <- which(tmp$Code %in% c(1,2))
    events <- responses-1
    tmp$Type <- NA
    tmp$Type[responses] <- as.character(tmp$Event.Type[events])

    if(length(tmp$Type[responses])!=length(tmp$Event.Type[events])) { print(file)}
    tmp$Event.Code <- NA
    tmp$Event.Code[responses] <- as.character(tmp$Code[events])
    tmp$Stim.Type[responses] <- as.character(tmp$Stim.Type[events])
    tmp$Duration[responses] <- as.character(tmp$Duration[events])
    tmp$Uncertainty.1[responses] <- as.character(tmp$Uncertainty.1[events])
    tmp$ReqTime[responses] <- as.character(tmp$ReqTime[events])
    tmp$ReqDur[responses] <- as.character(tmp$ReqDur[events])
    tmp$Pair.Index[responses] <- as.character(tmp$Pair.Index[events])


    tmp$Stim.Type[responses] <- as.character(tmp$Stim.Type[events])
    tmp <- tmp[tmp$Event.Type=="Response" & !is.na(tmp$Type),]
    tmp <- tmp[tmp$Type=="Picture" & !is.na(tmp$Type),]
    return(tmp)
}


read.files <- function(filesdir,skip=0){
    files <- paste(filedir,dir(filedir),sep="/")
    Reduce(rbind,lapply(files,read.file,skip=skip))}

### test
filedir <- "session1data/pretest"
pre <- read.files(filedir,skip=3)

filedir <- "session1data/pretest"
post <- read.files(filedir,skip=3)

###### pre
pre$Event.Code2 <- substr(pre$Event.Code,1,4)

ra <- read.table("r-course/Session_List_SYN_test1.txt") 
names(ra)[2] <- "corr.answer"
pre <- merge(pre,ra,by.x = "Event.Code2",by.y = "V1",all.x=T)

### !!!! other???
table(pre$Code==pre$corr.answer,pre$Stim.Type,useNA = "ifany")

file <- "r-course/logfiles/post-test/post018.txt"

tmp <- read.table(files[1],skip = 3,sep = "\t",header=T,na.strings = " +")
read.file(file)


###
require(dplyr)

a1 <- pre %>%
    group_by(Subject) %>%
    summarise(richtig.vor=sum(Stim.Type=="hit")/sum(Stim.Type %in% c("hit","incorrect")))

a2 <- post %>%
    group_by(Subject) %>%
    summarise(richtig.nach=sum(Stim.Type=="hit")/sum(Stim.Type %in% c("hit","incorrect")))

a1$Subject <- gsub("PRE","",a1$Subject)
a2$Subject <- gsub("POST","",a2$Subject)


merge(a1,a2)
