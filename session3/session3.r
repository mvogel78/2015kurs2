require(Hmisc)

x <- spss.get("session3/ZA5240_v2-0-0.sav")
## y <- stata.get("data/ZA5240_v2-0-0.dta")

## the column V417 contains the net income,
## calculate the mean using the mean() function!
## What is the problem?


nrow(x)
ncol(x)

mean(x$V417,na.rm = T)

mean(x$V417,trim=0.05,na.rm = T)


## summarize the net income using summary(), quantiles() and fivenum()!

summary(x$V417)
summary(x$V81)

quantile(x$V417,na.rm = T,probs = c(0,0.1,0.2,0.3,1))

quantile(x$V417,na.rm = T,probs = seq(0,1,by=0.05))

fivenum(x$V417)


## make a boxplot by using the following syntax!
require(ggplot2)
ggplot(x, aes(x=V86, y=V417)) +
    geom_boxplot()


ggplot(x, aes(x=V86, y=V417, fill=V81)) +
    geom_boxplot()


######################################################################
####################### T-Test #######################################
######################################################################


## one sample
set.seed(1)
x <- rnorm(12)

t.test(x,mu=0)

t.test(x,mu=1)


## two sample Welch or Satterthwaite test 
set.seed(1)
x <- rnorm(12)
y <- rnorm(12)
g <- sample(c("A","B"),12,replace = T)

t.test(x, y)
t.test(x ~ g)

t.test(x, y, var.equal = T)


######################################################################
####################### Exercises  ###################################
######################################################################

## do a t-test of income (V417): male against female (V81)!

t.test(x$V417 ~ x$V81)

## and compare the bmi (V279) in smokers and non-smokers (V272)
## and between the people with high and normal blood pressure (V242)

t.test(x$V279 ~ x$V272)
t.test(x$V279 ~ x$V242)


summary(x$V242)


## bmi by smokers/ non smokers
ggplot(x, aes(x=V272, y=V279, fill=V81)) +
    geom_boxplot() +
    facet_wrap( ~ V86)




summary(x$V272)

## bmi by high/normal blood pressure





## Alter
summary(x$V84)
