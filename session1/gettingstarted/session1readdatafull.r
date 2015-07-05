## install the package ggplot2
## either via the menu
## or via command line

install.packages("faraway")
install.packages("ggplot2")


## set working directory
setwd("/media/mandy/Volume/transcend/mpicbs/2015kurs/session1")

summary(read.table("session1data/fishercats.txt",  sep=" ",header=T))

winer <- read.table("http://socserv.socsci.mcmaster.ca/jfox/Courses/R/ICPSR/Winer.txt",
                    header=T)

## examples Duncan.xls, fishercats (caution!)
mydata2 <- read.delim("clipboard")  
mydata <- read.delim("clipboard",sep=" ")


## interactive data editing (caution!)
data(airquality)
aq <-edit(airquality)

fix(aq)

################################ our data frame #####################################
### read presentation files

pre1 <- read.table(file = "session1data/pre001.txt",
                sep = "\t",
                header = T,
                skip = 3,
                na.strings = "")


#####################################################################################
###################### Exercises Read in Data #######################################
#####################################################################################

## read in the files datatable1.txt and datatable2.txt (both are contained in the
## session1data directory! First look on the both of them, they need different
## specification of arguments! Assign them to a variable

data1 <- read.table("session1data/datatable1.txt",
                    sep="|",
                    dec=",",
                    header=T,
                    na.strings = "missing")

data2 <- read.table("session1data/datatable2.txt",
                    sep="\t",
                    header=T,
                    skip=1)


################################ indexing #####################################

## indexing with positive integers
letters[1:3]
letters[c(1:3,1:3)]


## logical indexing
x <- c(1,2,3,NA)
x[!is.na(x)]

## indexing in combination with assignment
x[is.na(x)] <- 0
x

## logical indexing on data frames
library(MASS)
painters[painters$Colour >= 17,]

## logical indexing on data frames (rows) combined with indexing with integers (columns)
painters[painters$Colour >= 17 & painters$Composition > 10, c(1,2,3)]


## use of %in%
painters[painters$School %in% c("A","C","D"),]

## use of which
which(painters$School %in% c("A","C","D"))

## indexing with character vector
painters[1:3,c("Drawing","Expression")]

## negative indeces
x <- c(5,8,6,7,1,5,3)
(z <- x[-1])

#####################################################################################
###################### Exercises Indices      #######################################
#####################################################################################

########## part A

## run the following commands!
## try to understand whats going on in each case!
x <- c(2, 7, 0, 9, 10, 23, 11, 4, 7, 8, 6, 0)
x[4]
x[3:5]
x[c(1, 5, 8)]
x[x > 10]
x[(1:6) * 2]
all(x > 0)
x[x == 0] <- 1
x

all(x > 0)
ifelse(round(x/2) == x/2, "even", "odd")

sum(x>4)

########## part B

## install and load the package faraway!
## use the names() function to list all column names of the data frame pima

install.packages("faraway")
require(faraway)
names(pima)

## use indexing to extract the bmi value of row 15-17
pima[15:17,"bmi"]

## use the sum() function to obtain the number
## of bmi values greater than 30 (like in the
## last line of part A)

sum(pima$bmi > 30)

## display lines 7-10 
pima[7:10,]

## display lines 7-10 but without column 2 and 3
pima[7:10,-c(2:3)]


################################ back to our data frame #####################################

## remove the first line 
pre1 <- pre1[-1,] 

########################## apply family ###############################################

tapply(quine$Days,quine$Lrn,mean)
tapply(quine$Days,list(quine$Eth,quine$Lrn),mean)

#####################################################################################
###################### Exercises Apply     ##########################################
#####################################################################################

## the class() function shows the class of an object
## use it in combination with lapply() to get the
## classes of the columns of the quine data frame
lapply(quine,class)

## do the same with sapply()
## what is the difference
sapply(quine,class)

## try to combine this with what you learned about indexing
## and create a new data frame quine2 only containing the columns
## which are factors
quine2 <- quine[,sapply(quine,class)=="factor"]

## use tapply() to summarise the number of missing days at school
## per Ethnicity and/or per Sex (three lines)
tapply(quine$Days,quine$Eth,mean)
tapply(quine$Days,quine$Sex,mean)

tapply(quine$Days,list(quine$Sex,quine$Eth),mean)


## sometimes the aggregate function is more convenient
## note the use of ~ ; it is read as 'is dependent on'
## it is extensivly used in modelling
aggregate(quine$Days,list(quine$Sex,quine$Eth),mean)
aggregate(Days ~ Sex + Eth, data=quine,mean)

aggregate(Days ~ Sex + Eth, data=quine,summary)

## compare the result of the last line to this one
tapply(quine$Days,list(quine$Sex,quine$Eth),summary)


################################ back to our data frame #################################

## Remove unnecessary spaces
## in addition to the use of lapply() we have to define a
## a function on our own
## we will cover the basics of function in the next session

pre1 <- lapply(pre1,function(x) {
    if( class(x) %in% c("character","factor") ){
        x <- factor(gsub(" ","",as.character(x)))
        return(x)}else{ return(x) }})  ## pre1 is now a list

## to data frame
pre1 <- as.data.frame(pre1)

## remove lines Pause Resume
pre1 <- pre1[!(pre1$Event.Type %in% c("Pause","Resume")), ]


## remove first and last lines
erste <- min(which((pre1$Code!=3 & !is.na(pre1$Code)))) - 1
pre1 <- pre1[-c(1:erste),]

letzte <- max(which(pre1$Code!=3 & !is.na(pre1$Code))) + 1
pre1 <- pre1[-c(letzte:nrow(pre1)),]


## rows marked as response
zeilen <- which(pre1$Event.Type %in% c("Response"))

## get the response line and the previous line 
zeilen <- sort(unique(c(zeilen,zeilen-1)))
zeilen <- zeilen[zeilen>0]

pre1 <- pre1[zeilen,]


## only responses 
responses <- which(pre1$Code %in% c(1,2))

## only events
events <- responses-1

## create new variable
pre1$Type <- NA

## set the new veriable for each response line
## to the event of the previous line
pre1$Type[responses] <- as.character(pre1$Event.Type[events])

## do the same for Stimulus Type, Duration, Uncertainty.1,Req.Time,ReqDur, Pair.Index
pre1$Stim.Type[responses] <- as.character(pre1$Stim.Type[events])
pre1$Duration[responses] <- as.character(pre1$Duration[events])
pre1$Uncertainty.1[responses] <- as.character(pre1$Uncertainty.1[events])
pre1$ReqTime[responses] <- as.character(pre1$ReqTime[events])
pre1$ReqDur[responses] <- as.character(pre1$ReqDur[events])
pre1$Pair.Index[responses] <- as.character(pre1$Pair.Index[events])

## Alternative na.locf (zoo package)
require(zoo)
pre1$Stim.Type <- na.locf(pre1$Stim.Type)
pre1$Duration <- na.locf(pre1$Duration)
pre1$Uncertainty.1 <- na.locf(pre1$Uncertainty.1)
pre1$ReqTime <- na.locf(pre1$ReqTime)
pre1$ReqDur <- na.locf(pre1$ReqDur)
pre1$Pair.Index <- na.locf(pre1$Pair.Index)

## keep only the "response" rows
pre1 <- pre1[pre1$Event.Type=="Response" & !is.na(pre1$Type),]
pre1 <- pre1[pre1$Type=="Picture" & !is.na(pre1$Type),]


table(pre1$Subject)
table(pre1$Event.Type)
table(pre1$Code)

pre1 <- droplevels(pre1)
table(pre1$Code)
table(pre1$Code,pre1$Stim.Type)


########################## combining data frames  #####################################
### rbind

x <- data.frame(id=1:3,score=rnorm(3))
y <- data.frame(id=13:15,score=rnorm(3))
rbind(x,y)


## cbind
x <- data.frame(id=1:5,score1=rnorm(5))
y <- data.frame(score2=rnorm(5),score3=rnorm(5))
cbind(x,y)


## merge
(d1 <- data.frame(id=LETTERS[c(1,2,3)],day1=sample(10,3)))
(d2 <- data.frame(id=LETTERS[c(1,3,5,6)],day2=sample(10,4)))

merge(d1,d2)

merge(d1,d2,all.x = T)

merge(d1,d2,all.y = T)

zz <- merge(d1,d2,all = T)


################################ back to our data frame ###############################
## join the person data with the pre1 data frame

#####################################################################################
############################### Exercises  ##########################################
#####################################################################################

## now read in the file personendaten.txt using the appropriate command
## join the demographics with our pre1 data frame (even it does not make sense
## now)

persdat <- read.table("session1data/personendaten.txt",
                      sep="\t",
                      header=T)

pre1 <- merge(persdat,pre1,all.y = T)
head(pre1)
summary(pre1)

################################ the functional Reduce ###############################

## Reduce

(d1 <- data.frame(id=LETTERS[c(1,2,3)],day1=sample(10,3)))
(d2 <- data.frame(id=LETTERS[c(1,3,5,6)],day2=sample(10,4)))
(d3 <- data.frame(id=LETTERS[c(2,4:6)],day3=sample(10,4)))
(d4 <- data.frame(id=LETTERS[c(1:5)],day4=sample(10,5)))

### example 1
Reduce(merge,list(d1,d2,d3,d4))
Reduce(function(x,y) { merge(x,y, all=T) } ,list(d1,d2,d3,d4))

na.omit(Reduce(function(x,y) { merge(x,y, all=T) } ,list(d1,d2,d3,d4)))


### example 2
d4$day <- names(d4)[2]
names(d4)[2] <- "score"
Reduce(function(x,y) { y$day <- names(y)[2]
                       names(y)[2] <- "score"
                       rbind(x,y) } ,list(d1,d2,d3), init = d4)


################################ back to our data frame ###############################
## functions

read.file <- function(file,skip=3,verbose=T){
    if(verbose) print(paste("read", file))
    tmp <- read.table(file,skip = skip,sep = "\t",header=T,na.strings = c(" +",""))
    tmp <- tmp[-1,]
    tmp <- lapply(tmp,function(x) {
        if( class(x) %in% c("character","factor") ){
            x <- factor(gsub(" ","",as.character(x)))
            return(x)}else{ return(x) }})
    tmp <- as.data.frame(tmp)
    tmp <- tmp[!(tmp$Event.Type %in% c("Pause","Resume")), ]

    first3 <- min(which(tmp$Code==3 & !is.na(tmp$Code)))
    equalsnot3 <- which(!(tmp$Code==3 & !is.na(tmp$Code)))
    first <- min(equalsnot3[equalsnot3 > first3])
    tmp <- tmp[-c(1:first),]
    

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

## read pre001.txt using the new function
pre1 <- read.file("session1data/pretest/pre001.txt")


## reading all files from a folder
filedir <- "session1data/pretest"
dir(filedir)

files <- paste(filedir,dir(filedir),sep = "/")
files

df.list <- lapply(files,read.file,skip=3)

length(df.list)
sapply(df.list,class)

pre <- Reduce(rbind,df.list)


## create a function
read.files <- function(filesdir,skip=3,...){
    files <- paste(filedir,dir(filedir),sep="/")
    Reduce(rbind,lapply(files,read.file,skip=skip))}

filedir <- "session1data/pretest"
pre <- read.files(filedir,skip=3)
table(pre$Subject)


#####################################################################################
############################### Exercises  ##########################################
#####################################################################################

## if you look at the result of table() - what is the problem?

## use the function read.files() to read the post test files from the directory
## name the data frame post
filedir <- "session1data/post-test"
post <- read.files(filedir,skip=3)
table(post$Subject) 

## use rbind() to join pre and post,
## call the now data frame test
test <- rbind(pre,post)

## table the subject variable
## what is the problem now?
table(test$Subject) 


### create a new variable id using the following line
## look at the resulting column and try to understand
## what is going on
test$id <- as.numeric(gsub("POST|PRE","",test$Subject))

## now read in the file subjectsdemographics.txt using the appropriate command
## join the demographics with our pre1 data frame (even it does not make sense
## now)

persdat <- read.table("session1data/subjectdemographics.txt",
                      sep="\t",
                      header=T)

test <- merge(persdat,test,by.x = "Subject",by.y = "id",all=T)
head(test)
summary(test)


## to see at least one graphic
require(ggplot2)
ggplot(test,aes(x=factor(Subject),fill=..count..)) + geom_bar()
