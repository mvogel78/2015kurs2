data(sleep)

## use of tapply
tapply(sleep$extra,sleep$group,FUN = mean)

## calculate the difference between the group means
orig.diff <- diff(tapply(sleep$extra,sleep$group,FUN = mean))

## calculate the absolute difference (two-sided test)
abs(diff(tapply(sleep$extra,sleep$group,FUN = mean)))

## sample
sample(sleep$group, size = length(sleep$group), replace = F)

## do it a 1000 times
res <- replicate(1000, abs(diff(tapply(sleep$extra,sample(sleep$group),FUN = mean))))

sum(orig.diff < res)/1000


## compare with t-test
t.test(extra ~ group, data = sleep)

t.test(sleep$extra ~ sleep$group)
