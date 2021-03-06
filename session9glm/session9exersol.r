## Exercise
## The excel file data.xlsx contains the worksheets mother and child
## containing respective parts of the births data set. Use the
## read_excel() command to read both data sets and

require(readxl)
excel_sheets("data.xlsx")

mdata <- read_excel("data.xlsx","mother")
cdata <- read_excel("data.xlsx","child")


## use merge() to join them
names(mdata)
names(cdata)

intersect(names(mdata),names(cdata))


births <- merge(mdata,cdata)
births <- merge(mdata,cdata,by=c("id","preterm"))

str(births)

summary(births$hyp)
births$hyp <- factor(births$hyp,levels = c("normal","hyper"))
summary(births$hyp)

summary(births$lowbw)
births$lowbw <- factor(births$lowbw,levels = c("normal","low"))
summary(births$lowbw)

summary(births$sex)
births$sex <- factor(births$sex,levels = c("M","F"))
summary(births$sex)

summary(births$preterm)
births$preterm <- factor(births$preterm,levels = c("preterm","normal"))
summary(births$preterm)

## from lm() to glm()
m1 <- lm(bweight ~ hyp, data=births)
m2 <- glm(bweight ~ hyp, family=gaussian, data=births)

## binary response
y <- sample(0:1,100, replace = T)

plot(y)
abline(h=mean(y))

p <- seq(0,1,by=0.05)

p/(1-p)

log(p/(1-p))

## inverse logit function

invlogit <- function(x){
    exp(x)/(1+exp(x))
}

## install and load the arm package, there is also a invlogit function

## low birth weight model
m <- glm(lowbw ~ hyp, family=binomial, data=births)

invlogit(coef(m)[1])
invlogit(coef(m)[1] + coef(m)[2])

table(births$lowbw,births$hyp)

40/(388+40)
20/(52 + 20)

## proportion test
prop.test(c(20,40),c(72,428))
chisq.test(table(births$lowbw,births$hyp))

## effects plot
require(effects)
Effect("hyp",m)

plot(Effect("hyp",m))

## effects
Effect("hyp",m)


## controlling for sex
m2 <- glm(lowbw ~ hyp+sex, family=binomial, data=births)
summary(m2)

invlogit(coef(m2)[1])

m3 <- glm(lowbw ~ hyp*sex, family=binomial, data=births)
summary(m3)



Effect("hyp",m2)
Effect("sex",m2)

plot(Effect("hyp",m2))
plot(Effect("sex",m2))

Effect(c("hyp","sex"),m2)
Effect(c("sex","hyp"),m2)

plot(Effect(c("hyp","sex"),m2))
plot(Effect(c("sex","hyp"),m2))



## Exercise
## the estimated probability for moms with hypertension to get
## a baby with low birth weight for all three models

Effect("hyp",m)
Effect("hyp",m2)
Effect("hyp",m3)


## is their a difference in effects between boys and girls?
## Which model can answer this question?

allEffects(m2)
allEffects(m3)

plot(Effect(c("hyp","sex"),m3))

m4 <- glm(lowbw ~ sex + sex:hyp, family=binomial, data=births)
summary(m4)

m4 <- glm(lowbw ~ sex/hyp, family=binomial, data=births)
m4

## Exercise
allEffects(m3)
allEffects(m4)

## understanding the coefficients
ftable(births$hyp,
       births$sex,
       births$lowbw)


## logistic regression
m5 <- glm(lowbw ~ gestwks, family = binomial, data= births)
summary(m5)

## understanding the effects
### intercept
invlogit(coef(m5)[1])

### slope
exp(coef(m5)[2])

p.from.odds <- function(odds) odds/(1+odds)
odds.from.p <- function(p) p/(1-p)

odds.from.p(0.01779725)/odds.from.p(0.04252149)


## exercise

Effect("gestwks",m5)
Effect("gestwks",m5,xlevels = list(gestwks = c(20,30,40)))

## use the command to gain the estimated probability of
## low birth weight for a gestational age of 27 and 36 weeks

Effect("gestwks",m5,xlevels = list(gestwks = c(27,36)))


require(ggplot2)
ggplot(births,aes(x = gestwks, y = as.numeric(lowbw)-1)) +
    geom_smooth(method = "glm", family = "binomial",se = T,size = 2) +
    geom_point(shape="|")

ggsave("img/glmggplot.png")


## try to change the axis titles (xlab() and ylab())
## add a title (ggtitle())

ggplot(births,aes(x = gestwks, y = as.numeric(lowbw)-1)) +
    geom_smooth(method = "glm", family = "binomial",se = T,size = 2) +
    geom_point(shape="|") +
    xlab("gestational age") +
    ylab("probability of low birth weight") +
    ggtitle("probability of low birth weight dependent on gestational age")

## change the colour of the function to black
## change the colour of the points to red for the low birth weight
## and to green for the one with normal birth weight
ggplot(births,aes(x = gestwks, y = as.numeric(lowbw)-1)) +
    geom_smooth(method = "glm", family = "binomial",
                se = T,size = 2, colour = "black") +
    geom_point(shape="|",aes(colour = lowbw),size = 3) +
    scale_colour_manual(values = c("forestgreen","firebrick")) +
    xlab("gestational age") +
    ylab("probability of low birth weight") +
    ggtitle("probability of low birth weight dependent on gestational age")


## change the position of the legend;
## place it somewhere near the upper right corner
## inside the plotting area
ggplot(births,aes(x = gestwks, y = as.numeric(lowbw)-1)) +
    geom_smooth(method = "glm", family = "binomial",
                se = T,size = 2, colour = "black") +
    geom_point(shape="|",aes(colour = lowbw),size = 3) +
    scale_colour_manual(values = c("forestgreen","firebrick")) +
    xlab("gestational age") +
    ylab("probability of low birth weight") +
    ggtitle("probability of low birth weight dependent on gestational age") +
    theme(
        legend.position = c(0.9,0.85)
    )
