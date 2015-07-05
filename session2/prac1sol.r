## 1
# 33. Try to use R as a calculator: What is greater exp(pi) oder pi^e.
exp(pi) > pi**exp(1)

max(c(exp(pi),pi**exp(1)))

which.max(c(exp(pi),pi**exp(1)))










## 3
# 1 Create a vector w with components 1, -1, 2, -2
(w <- c(1,-1,2,-2)) # or
(w <- rep(c(1,2),c(2,2)) * c(1,-1)) ## just interesting if you want to create a vector like this
# 2
w
# 3
str(w)
# 4
w + 1
# 5
v <- c(0,1,seq(5,75,by=5))
# 6
length(v)

## 3
x <- c(2, 7, 0, 9, 10, 23, 11, 4, 7, 8, 6, 0)
x[4]
x[3:5]
x[c(1, 5, 8)]

x > 10
i <- x > 10
x[x > 10]

x[i]

i <- (1:6) * 2
x[(1:6) * 2]
x[i]

x == 0
x[x == 0] <- 1
x

round(x/2) == x/2

ifelse(round(x/2) == x/2, "even", "odd")

# 3 part 2
# using a numeric index
(i <- seq(3,length(x),by=3))
(i <- c(3,6,9,12))
(i <- (1:4)*3)

x[seq(3,length(x),by=3)]
x[i]

# using logic index
(i <- c(1:length(x)) %% 3 == 0)
x[i]

# 2
(i <- x > 4 & x < 10)
x[i]

# 3
(i <- x > 10)
x[i] <- 10
x ## or shorter
x[x > 10] <- 10

# 4
(i <- x < 5)
x[i] <- x[i]*2

x[x < 5] <- x[x < 5]*2

x <- ifelse(x < 5,x*2,x)

# 5
y <- rep(0:1,6)

(z1 <- ifelse(y==0,x,3*x))

(z2 <- x+x*y*2)

(z3 <- x*(1+y*2))


### 3.2
load("presidential.rdata")
presidential

## 1
presidential[presidential$party=="Republican",]

## 2
presidential[presidential$party=="Democratic",]

## 3
presidential[presidential$duration > 3 & presidential$duration < 6,]

## 4
#### table
table(presidential$party)

### true of duration max (8)
presidential$durmax <- presidential$duration==8

#### table party - durmax
table(presidential$party,presidential$durmax)


####
load("201404zeiten.rdata")

head(t098)
names(t098)
summary(t098)


t098$dauer <- t098$ENDE - t098$BEGINN

t098$dauer <- as.numeric(t098$ENDE - t098$BEGINN)/60

t098$dauer[t098$dauer > 60] <- NA


summary(t098)

hist(t098$dauer)
