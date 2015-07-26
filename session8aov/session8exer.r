setwd("/media/mandy/Samsung_T1/201505kurs/session8aov/")

########################## combining data frames  ################################## rbind

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


## Exercises mergen
require(readxl)
## excel_sheets() given a filename returns all available sheets 

## read_excel() takes the filename and the sheet name (or position)
## and reads in the data 





















## Exercises Anova
