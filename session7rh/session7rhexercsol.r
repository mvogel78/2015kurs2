## For the Cars93 (MASS) data set, answer the following:
## For MPG.highway modeled by Horsepower, find the simple regression
## coefficients. What is the predicted mileage for a car with 225 horsepower?

require(MASS)
m1 <- lm(MPG.highway ~ Horsepower, data = Cars93)
summary(m1)

coef(m1)
coef(m1)[1] + coef(m1)[2] * 225

predict(m1, newdata = list(Horsepower = 225))

## Fit the linear model with MPG.highway modeled by Weight.
## Find the predicted highway mileage of a 6,400 pound HUMMER H2 and
## a 2,524 pound MINI Cooper.

m2 <- lm(MPG.highway ~ Weight, data = Cars93)
summary(m2)
coef(m2)

coef(m2)[1] + coef(m2)[2] * 6400
coef(m2)[1] + coef(m2)[2] * 2524

predict(m2, newdata = list(Weight = c(6400,2524)))

## Fit the linear model Max.Price modeled by Min.Price.
## Why might you expect the slope to be around 1 ?

m3 <- lm(Max.Price ~ Min.Price, data = Cars93)
summary(m3)
coef(m3)


## For the data set MLBattend (UsingR) concerning major league baseball
## attendance, fit a linear model of attendance modeled by wins.
## What is the predicted increase in attendance if a team that won 80
## games last year wins 90 this year?

require(UsingR)
m4 <- lm(attendance ~ wins, data = MLBattend)
summary(m4)
coef(m4)

coef(m4)[2] * 10


## People often predict children’s future height by using their
## 2-year-old height. A common rule is to double the height.
## Table 10.2 contains data for eight people’s heights as 2-year-olds
## and as adults. Using the data, what is the predicted adult height
## for a 2-year-old who is 33 inches tall?

data <- data.frame(age2 = c(39,30,32,34,35,36,36,30),
                   adult = c(71,63,63,67,68,68,70,64))

m5 <- lm(adult ~ age2, data = data)
summary(m5)
coef(m5)

coef(m5)[1] + coef(m5)[2] * 33
predict(m5,newdata = list(age2=33))


## With the \texttt{rmr} (ISwR) data set, plot metabolic rate versus
## body weight. Fit a linear regression model to the relation. According
## to the fitted model, what is the predicted metabolic rate for a body
## weight of 70 kg? Give a 95\% confidence interval for the slope of the line.

require(ISwR)
m6 <- lm(metabolic.rate ~ body.weight, data = rmr)
summary(m6)

## In the juul (ISwR) data set, fit a linear regression
## model for the square root of the IGF-I concentration versus age
## to the group of subjects over 25 years old.
## look at the use  of  the subset argument in this tutorial:
## http://ww2.coastal.edu/kingw/statistics/R-tutorials/simplelinear.html

m7 <- lm(sqrt(igf1) ~ age, data = juul, subset = (age > 25))
summary(m7)


## In the malaria data set, analyze the log-transformed antibody level
## versus age. Make a plot of the relation. Do you notice anything peculiar?

m8 <- lm(log(ab) ~ age, data = malaria)
ggplot(malaria,aes(x = age, y = log(ab))) +
    geom_point() +
        geom_smooth(method="lm")