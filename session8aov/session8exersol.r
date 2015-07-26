setwd("/media/mandy/Samsung_T1/201505kurs/session8aov/")

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
