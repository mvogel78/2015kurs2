lm(mpg ~ cyl, data = mtcars))

head(mtcars)

require(dplyr)
mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg),
                                       disp = mean(disp),
                                       )


