require(ggplot2)
## load the data set GaltonFamilies from the package HistData 
require(HistData)

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

## dot plots
ggplot(mtcars, aes(x = mpg)) + geom_dotplot()
ggsave("dotplot1.png")

ggplot(mtcars, aes(x = mpg)) + geom_dotplot(binwidth = 1.5)
ggsave("dotplot2.png")

## Use fixed-width bins
ggplot(mtcars, aes(x = mpg)) +
    geom_dotplot(method="histodot", binwidth = 1.5)
ggsave("dotplot3.png")

## Some other stacking methods
ggplot(mtcars, aes(x = mpg)) +
    geom_dotplot(binwidth = 1.5, stackdir = "center")
ggsave("dotplot4.png")





## Exercises
## use again the GaltonFamilies data set; produce a scatter plot
## of childHeight vs midparentHeight





##add a trend line by using geom\_smooth() without any
## arguments. Which method is used?



## add a second trend line, this time a linear one!




## now use the aesthetic colour in the first line of the plot
## definition. What happens?






## INBOtheme
install.packages("INBOtheme", repos="http://R-Forge.R-project.org")
require(INBOtheme)

p1 + theme_elsevier()
ggsave("testelsevier.png",width = 15, height = 10, units = "cm")

p1 + theme_INBO()
p1 + theme_map()
p1 + theme_inbo2015()


## density legends
install.packages("oaPlots", repos = "http://repos.openanalytics.eu", type = "source")

require(oaPlots)
scatterplotDL(GaltonFamilies$mother,GaltonFamilies$childHeight,
              colorVar = GaltonFamilies$childHeight,
              colorPalette = INBOextra,
              pch = 19)

scatterplotDL(GaltonFamilies$mother,GaltonFamilies$childHeight,
              colorVar = GaltonFamilies$childHeight,
              colorPalette = blues9,
              pch = 19)

savePlot("legendexample.png")

## membranes and tritiated water
data <- data.frame(values = c(0.8,0.83,1.89,1.04,1.45,
                       1.38,1.91,1.64,0.73,1.46,
                       1.15,0.88,0.9,0.74,1.21),
                   membrane = rep(LETTERS[1:2],c(10,5)))

## histogram





## test





## weight loss programs

## data
data <- data <- data.frame(x=c(12.42,9.31,6.83,11.51,10.42,8.87,6.73,9.53,8.8,8.01,7.01,9.69),
                   y=c(13.8,10,8.51,11.95,10.66,8.76,7.93,11.81,11.62,9.76,9.2,11.2))


## investigate deviation from normality
## histogram


## test



## visualization



## magnets (require(), data())

