## Tutorial for the Lattice Ploting System
## at Coursera Data Science - Exploratory Data Analysis
##
## The lattice plotting system is implemented using the following packages:
## - lattice: contains code for producing Trellis graphics, which are independent of the “base” graphics
##            system; includes functions like xyplot, bwplot, levelplot
## - grid:    implements a different graphing system independent of the “base” system; the lattice
##            package builds on top of grid
##
## Lattice graphics functions return an object of class trellis.
## On the command line, trellis objects are auto-printed so that it appears the function is plotting the data.

## 1. Simple lattice plot
library(lattice)
library(datasets)

## 1.1 Plot directly
xyplot(Ozone ~ Wind, data = airquality)

## 1.2 Plot in different panels
airquality <- transform(airquality, Month = factor(Month)) 
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1)) ## Auto-printing

## 1.3 Using trellis objects
p <- xyplot(Ozone ~ Wind, data = airquality) ## Nothing happens! 
print(p) ## Plot appears

## 1.4 Lattice panel functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50) 
y<-x+f-f*x+rnorm(100,sd=0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1)) ## Plot with 2 panels

## 1.5 Custom panel function with median
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) ## First call the default panel function for 'xyplot' 
    panel.abline(h = median(y), lty = 2) ## Add a horizontal line at the median
})

## 1.6 Custom panel function with linear regression
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) ## First call default panel function 
    panel.lmline(x, y, col = 2) ## Overlay a simple linear regression line
})

