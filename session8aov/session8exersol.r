setwd("/media/mandy/Samsung_T1/201505kurs/session8aov/")

########################## combining data frames  #####################################
### rbind

x <- data.frame(id=1:3,score=rnorm(3))
y <- data.frame(id=13:15,score=rnorm(3))
z <- rbind(x,y)


## cbind
x <- data.frame(id=1:5,score1=rnorm(5))
y <- data.frame(score2=rnorm(5),score3=rnorm(5))
z <- cbind(x,y)


## merge
(d1 <- data.frame(id=LETTERS[c(1,2,3)],day1=sample(10,3)))
(d2 <- data.frame(id=LETTERS[c(1,3,5,6)],day2=sample(10,4)))

merge(d1,d2,by="id")

merge(d1,d2,all.x = T)

merge(d1,d2,all.y = T)

zz <- merge(d1,d2,all = T)


## Exercises
require(readxl)
## excel_sheets() given a filename returns all available sheets 
excel_sheets("nhanes1112.xlsx")

## read_excel() takes the filename and the sheet name (or position)
## and reads in the data 
demogr <- read_excel("nhanes1112.xlsx","demographics")
bp <- read_excel("nhanes1112.xlsx","bp")
physact <- read_excel("nhanes1112.xlsx","physactivity")
bm <- read_excel("nhanes1112.xlsx","bodymeas")

## demogr <- read_excel("nhanes1112.xlsx",1)

data <- merge(demogr,bp,by = "seqn")
data <- merge(data,bm,by.x = "seqn", by.y = "seqn")
data <- merge(data,physact)


data <- merge(demogr,bp,by = "seqn", all = T)
data <- merge(data,bm,by.x = "seqn", by.y = "seqn", all = T)
data <- merge(data,physact, all = T)


require(granovaGG)
data(arousal)

data.long <- stack(arousal)

granovagg.1w(data.long$values,data.long$ind)
