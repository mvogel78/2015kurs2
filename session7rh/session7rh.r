require(ggplot2)
load("births.rdata")

## relationship bweight ~ gestwks
m <- lm(bweight ~ gestwks, data=births)
summary(m)

coef(m)

ggplot(births, aes(x = gestwks,y = bweight)) +
    geom_point() +
    geom_abline(intercept = coef(m)[1],
                slope = coef(m)[2])

ggsave("img/model1.png")


## relationship bweight ~ hyp + gestwks
m <- lm(bweight ~ hyp + gestwks, data=births)
summary(m)

coef(m)

ggplot(births, aes(x = gestwks,y = bweight)) +
    geom_point() +
    geom_abline(intercept = coef(m)[1],
                slope = coef(m)[3],colour="blue") +
    geom_abline(intercept = coef(m)[1] + coef(m)[2],
                slope = coef(m)[3],colour="red")

## relationship bweight ~ hyp * gestwks
m <- lm(bweight ~ hyp * gestwks, data=births)
summary(m)


## center variable to get meaningful intercept
births$gwsc <- births$gestwks-40
m <- lm(bweight ~ hyp * gwsc, data=births)
summary(m)
