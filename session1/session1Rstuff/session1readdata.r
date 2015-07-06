## install the package ggplot2
## either via the menu
## or via command line

2 + 2
2 + 3
2 + 2

exp(-2)

round(exp(-2),3)

x <- rnorm(100,mean=4,sd=2)
y <- 2*x + rnorm(100,mean=0,sd=0.2)

plot(x)

lm(y ~ x)

mm <- lm(y ~ x)
summary(mm)

str(mm)

################## Exercises ########################

## load the MASS package
library(MASS)

## load the Pima.te data
data(Pima.te)

## type ?Pima.te


## type names(Pima.te)


## use head() on the Pima.te data set


## use summary() on the Pima.te data set


## use the dollar sign to access the skin column of the
## Pima.te data set


## set working directory
## either via the menu
## or via command line
setwd("/media/mandy/Samsung_T1/201505kurs/session1/session1Rstuff/")

## Examples
summary(read.table("session1data/fishercats.txt",  sep=" ",header=T))

winer <- read.table("http://socserv.socsci.mcmaster.ca/jfox/Courses/R/ICPSR/Winer.txt",
                    header=T)

## interactive data editing (caution!)
data(airquality)
aq <-edit(airquality)

fix(aq)

require(readxl)
content <- read_excel("data/Duncan.xls")
head(content)


## XLConnect provides also writing capabilities
require(XLConnect)
wb <- loadWorkbook("data/Duncan.xls")
getSheets(wb)
xx <- readWorksheet(wb,"Duncan")
createSheet(wb,"data2")
writeWorksheet(wb,winer,"data2")
saveWorkbook(wb)



## read in the files datatable1.txt and datatable2.txt (both are contained in the
## session1data directory! First look on the both of them, they need different
## specification of arguments! Assign them to a variable


data1 <- read.table("data/datatable1.txt",sep= ,header=   )
summary(data1)

data2


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
painters$Colour >= 17
## logical indexing on data frames (rows) combined with indexing with integers (columns)
painters[painters$Colour >= 17 & painters$Composition > 10, c(1,2,3)]
painters[painters$Colour >= 17 & painters$Composition > 10, 1:3]


## use of %in%
painters[painters$School %in% c("A","C","D"),]
painters[painters$School == "A" | painters$School == "C" | painters$School == "D",]



painters$School %in% c("A","C","D")


## use of which
which(painters$School %in% c("A","C","D"))

## indexing with character vector
painters[1:3,c("Drawing","Expression")]

## negative indeces
x <- c(5,8,6,7,1,5,3)
(z <- x[-1])

x[-c(1,4,5)]
x[-(1:3)]

-1:3

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


x[which(x > 10)]

(1:6) * 2
x[(1:6) * 2]

all(x > 0)


x[x == 0]
x[x == 0] <- 1
x

all(x > 0)

ifelse(round(x/2) == x/2, "even", "odd")

x>4
sum(x>4)

########## part B
## load the MASS package (if not already done)
## use the names() function to list all column names of the data frame Pima.te




## use indexing to extract the bmi value of row 15-17



## use the sum() function to obtain the number
## of bmi values greater than 30 (like in the
## last line of part A)



## display lines 7-10 


## display lines 7-10 but without column 2 and 3



