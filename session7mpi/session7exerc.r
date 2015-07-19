## load the data frame normtemp, which is contained in the UsingR package;
## it contains the body temperature of several individuals,
## the gender and the heart rate
require(UsingR)


## test if the temperature is different in male (coded as 1)
## and female (coded as 2), use the appropriate test.







## shapiro.test (i do not recommend tests)





## test again, compare the results of the t test and the wilcoxon.


## plot the respective boxplots!




## The data set slc contains data on red blood cell sodium-lithium
## countertransport activity for 190 individuals. Describe the shape
## of the distribution, estimate the center, state what is an
## appropriate measure of center for this data.






## Load the data set vacation This gives the number of paid holidays
## and vacation taken by workers in the textile industry.





## t test: if appropriate, test the null hypothesis that $\mu = 24$. 


## Repeat the above for the Simple data set smokyph. This data set
## measures pH levels for water samples in the Great Smoky Mountains.
## Use the waterph column smokyph[[’waterph’]] to
## test the null hypothesis that mu = 7.









## In the babies (UsingR) data set, the variable dht contains the
## father’s height. Do a significance test of the null hypothesis that
## the mean height is 68 inches against an alternative that it is taller.
## Remove the values of 99 from the data, as these indicate missing data.





## Suppose a cell-phone bill contains this data for the number
## of minutes per call:

call.min <- c(2,1,3,3,3,3,1,3,16,2,2,12,20,31)

## Is this consistent with an assumption that the median call
## length is 5 minutes, or does it indicate that the median length
## is less than 5?

require(PASWR)



## the babies (UsingR) data set contains data covering many births.
## Information included is the gestation period, and a factor
## indicating whether the mother was a smoker. Extracting the rows
## for mothers who smoked during pregnancy can be done with these commands:

require(dplyr)
babies <- filter(babies, smoke == 1 & gestation != 999)

