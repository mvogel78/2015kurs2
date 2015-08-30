## Infection Example
infection <- read.table("infection.txt",header=T)

head(infection)

summary(infection)

infection$infected <- factor(infection$infected,
                             levels = 0:1,
                             labels = c("infected","not infected"))

infection$sex <- factor(infection$sex,
                             levels = 0:1,
                             labels = c("female","male"))

save(infection,file = "infection.rdata")

load("infection.rdata")
summary(infection)

m.inf <- glm(infected~age*sex,family=binomial,
                               data=infection)

summary(m.inf)



## coefficients
### intercepts
invlogit(coef(m.inf)[1])
invlogit(coef(m.inf)[1] + coef(m.inf)[3])

### slopes
exp(coef(m.inf)[2])
exp(coef(m.inf)[2] + coef(m.inf)[4])

exp(30 * coef(m.inf)[2])
exp(30 * (coef(m.inf)[2] + coef(m.inf)[4]))

solve(0.015657,3.000513)
solve(0.02670685,2.883849)

## all effects

allEffects(m.inf)

allEffects(m.inf,
           xlevels = list(age = seq(0,200,by = 50)))



ggplot(infection,aes(y = as.numeric(infected) - 1, x = age,colour = sex, shape = sex)) +
    geom_jitter(size = 3,
                position = position_jitter(height = 0.02, width = 2)) +
    geom_smooth(method = "glm", family = "binomial") +
    scale_shape_manual(values = c("male" = "\u2642","female" = "\u2640")) +
    scale_colour_manual(values = c("male" = "midnightblue",
                                   "female" = "deeppink")) +
    scale_y_continuous(labels = percent) +
    labs(x = "age (days)",
         y = "infected (percent)") +
    theme_bw() +
    theme(
        legend.position = c(0.1,0.8)
    )
    
ggsave("img/binancova1.png")


## different link functions
ggplot(births,aes(x = gestwks, y = as.numeric(lowbw)-1)) +
    geom_smooth(method = "glm", family = "binomial",se = T,size = 2) +
    geom_smooth(method = "glm", family = binomial(link = "probit"),se = T,size = 2, colour = "red") +
    geom_smooth(method = "glm", family = binomial(link = "cloglog"),se = T,size = 2, colour = "green") +
    geom_point(shape="|")


## multiple linear regression
sc.race <- read.table("ScotsRaces.dat",header = T)
m1 <- lm(time ~ climb + distance, data = sc.race)
m1

resid(m1)
