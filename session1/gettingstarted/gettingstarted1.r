dim(available.packages())

x <- rnorm(100, mean=2, sd=4)
y <- 2 * x  + rnorm(100, mean=0, sd=0.5)

lm(y~x)

mm <- lm(y~x)

summary(mm)
plot(mm)

plot(x,y)
abline(mm)


str(mm)

