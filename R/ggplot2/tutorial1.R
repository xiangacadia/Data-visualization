## Tutorial for the ggplot2 in R
## at Coursera Data Science - Exploratory Data Analysis
##
## ggplot2 is an implementaion of the Grammar of Graphics by Leland Wilkinson

library(ggplot2)
library(datasets)

## 1. Using qplot in ggplot2
##    The qplot() function is the analog to plot() but with many built-in features.
##
## 1.1 ggplot2 "hello world" qplot
qplot(Ozone, Temp, data=airquality)

## 1.2 Modifing asethetics - color
qplot(Ozone, Temp, data=airquality, color=Month)

## 1.3 Adding a geom - smooth
qplot(Ozone, Temp, data=airquality, geom=c("point", "smooth"))

## 1.4 Histograms - only for one variable
qplot(Temp, data=airquality, fill=Month)

## 1.5 Adding facets in scatter plot
qplot(Ozone, Temp, data=airquality, facets=.~Month, color=Day)

## 1.6 Adding facets in histogram
qplot(Temp, data=airquality, facets=Month~.)

## 1.7 Adding density smooth
qplot(Temp, data=airquality, geom="density")
qplot(Temp, data=airquality, geom="density",color=Month)

## 1.8 Linear regression for scatter plots
qplot(Ozone, Temp, data=airquality, geom=c("point", "smooth"), method="lm",color=Month)

## 2. Using ggplot() in ggplot2
##
## 2.1 Basics
load("/Users/xiangjiang/Downloads/maacs.Rda")
head(maacs)
g <- ggplot(maacs, aes(pm25, eno))
g + geom_point() ## auto-print object without saving

## 2.2 Adding smoothing
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")

## 2.3 Adding more layers - facets
g + geom_point() + facet_grid(. ~ mopos) + geom_smooth(method = "lm")

## 2.4 Modifying Aesthetics
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)

## 2.5 Modifying labels
g + geom_point(aes(color=mopos))+labs(title = "MAACS Cohort") + labs(x = expression("log * PM[2.5]"), y = "Nocturnal Symptoms")

## 2.6 Customizing the Smooth
g + geom_point() + facet_grid(. ~ mopos) + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

## 2.7 Changing the Theme
g + geom_point() + geom_smooth()+ theme_bw(base_family = "Times")

## 3. A Notes about Axis Limits
##    should be very careful with changing the coordinates
## 3.1 Generate data
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100  ## Outlier!!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

## 3.2 Plot data with ggplot
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

## 3.3 Only change the limits will not work
##     this is because R just discard the outside points
g + geom_line() + ylim(-3, 3)

## 3.4 This is how to change coordinates correctly
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
