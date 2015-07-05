## load the data
load("data/studrecords.rdata")

## Test the null hypothesis that the population mean math score
## is 500 against a two-sided alternative. Would you accept or
## reject at a 0.05 significance level?

t.test(stud.recs$sat.m, mu = 500)

## Test the null hypothesis that the mean math score is equal
## to the mean verbal (sat.v) score against a two sided hypothesis.
t.test(stud.recs$sat.m, stud.recs$sat.v)


## Test the null hypothesis that the verbal and the math score
## is equal in each student.
t.test(stud.recs$sat.m, stud.recs$sat.v, paired = T)


## Wilcoxon signed-rank test
pre.test <- c(17,12,20,12,20,21,23,10,15,17,18,18)
post.test <- c(19,25,18,18,26,19,27,14,20,22,16,18)

wilcox.test(pre.test,post.test,paired = T)

## exercises
## load the data frame normtemp from the file temperature.rdata;
## it contains the body temperature of several individuals,
## the gender and the heart rate
load("data/temperature.rdata")


## test if the temperature is different in male (coded as 1)
## and female (coded as 2), use the appropriate test.
t.test(temperature ~ gender, data = normtemp)


## test again, compare the results of the t test and the wilcoxon.
wilcox.test(temperature ~ gender, data = normtemp)


require(ggplot2)
ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot()



## add another layer
ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot() +
    geom_point()

ggsave("boxplotpoint.png")


ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot() +
    geom_jitter()


ggsave("boxplotjitter.png")



ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot() +
    geom_jitter(position=position_jitter(width=0.1))


ggsave("boxplotjitter2.png")

ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot() +
    geom_point(stat = "summary", fun.y = "mean")

ggsave("boxplotmean.png")


ggplot(normtemp, aes(x = factor(gender), y = temperature)) +
    geom_boxplot() +
    geom_point(stat = "summary", fun.y = "mean",
               size = 5, colour = "red")

ggsave("boxplotmean2.png")




## Exercises

## load the data set GaltonFamilies from the package HistData 
require(HistData)

## make a boxplot of childHeight dependent on gender
## add the means using geom_point()
ggplot(GaltonFamilies, aes(x = gender, y = childHeight)) +
    geom_boxplot() +
    geom_point(stat = "summary", fun.y = "mean",
               size = 5, colour = "red") +
    geom_text(aes(label = round(..y..,1)), stat = "summary", fun.y = "mean",
               size = 5, colour = "red",vjust=-0.6)


## do the respective t-test: what is the (trivial) null hypothesis,
## what is appropriate test, what is the test result and what is
## the conclusion?
t.test(childHeight ~ gender, data = GaltonFamilies)


## bivariate plots
ggplot(GaltonFamilies, aes(x=mother,y=father)) +
    geom_point() 


ggsave("scatter.png")

## adding a trend line
ggplot(GaltonFamilies, aes(x=mother,y=father)) +
    geom_point() +
    geom_smooth()

ggsave("scattertrend1.png")



## adding a trend line
ggplot(GaltonFamilies, aes(x=mother,y=father)) +
    geom_point() +
    geom_smooth(method="lm")

ggsave("scattertrend2.png")


## Exercises
## use again the GaltonFamilies data set; produce a scatter plot
## of childHeight vs midparentHeight

ggplot(GaltonFamilies, aes(x=midparentHeight,y=childHeight)) +
    geom_point() 


##add a trend line by using geom\_smooth() without any
## arguments. Which method is used?
ggplot(GaltonFamilies, aes(x=midparentHeight,y=childHeight)) +
    geom_point() +
    geom_smooth() 


## add a second trend line, this time a linear one!
ggplot(GaltonFamilies, aes(x=midparentHeight,y=childHeight)) +
    geom_point() +
    geom_smooth() +
    geom_smooth(method="lm")


## now use the aesthetic colour in the first line of the plot
## definition. What happens?
ggplot(GaltonFamilies, aes(x=midparentHeight,y=childHeight,colour=gender)) +
    geom_point() +
    geom_smooth() +
    geom_smooth(method="lm")
