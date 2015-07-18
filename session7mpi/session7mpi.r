data(sleep)

## use of tapply
tapply(sleep$extra,sleep$group,FUN = mean)

## use of replicate
## roll 6 dice
sample(1:6,size = 1)
## roll 6 dice 10000 times 
dice <- replicate(10000,sum(sample(1:6,size = 6,replace = T)))
table(dice)

### Permutation tests
## calculate the difference between the group means
diff(tapply(sleep$extra,sleep$group,FUN = mean))

## calculate the absolute difference (two-sided test)
orig.diff <- abs(diff(tapply(sleep$extra,sleep$group,FUN = mean)))

## do it a 10000 times
res <- replicate(10000, abs(diff(tapply(sleep$extra,sample(sleep$group),mean))))
sum(orig.diff <= res)/10000 ## p-value

## compare with t-test
t.test(sleep$extra ~ sleep$group)

### Rank Based Permutation tests

### Exercises
require(dplyr)
babies <- filter(babies, smoke == 1 & gestation != 999)
