#ggplot2 library
library(ggplot2)


f <- function(x) {
  
  # Define your function here in terms of x, for example:
  return(x^2)
}

# Define upper and lower limit
a <- 0
b <- 1

#get points from a to b
pts <- seq(a,b,by=.1)


#represent y as a function of x
y <- f(pts)

#store points as a data frame
points <- data.frame(
  x = pts,
  y = y
)

# Define the number of partitions
n <- 4

# Calculate the width of each partition (dx)
width <- (b - a) / n


shape <- data.frame(
  xleft = seq(a, b - width, by = width),
  xright = seq(a + width, b, by = width),
  lHeight = f(seq(a, b - width, by = width)),
  rHeight = f(seq(a + width, b, by = width))
)
#print(width)
#print(shape$xleft)
#print(shape$xright)
#print(shape$lHeight)
#print(shape$rHeight)

shape$area <- f((shape$xleft + shape$xright)/2) * width
totalArea <- cumsum(shape$area)
midpointEstimate = totalArea[length(shape$area)]
cat(midpointEstimate)
ggplot() +
  geom_rect(
    data = shape,
    aes(xmin = xleft, xmax = xright, ymin = a, ymax = (rHeight+lHeight)/2),
    fill = "pink", color = "black"
  ) +
  geom_line(
    data = points,
    aes(x, y)
  )+
  theme_minimal()