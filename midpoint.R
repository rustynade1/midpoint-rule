#ggplot2 library
library(ggplot2)
midpoint <- function(input, output){
  
  
  observeEvent(input$calculate_btn,{
    iFunc <- reactive({input$input_func()})
    #print(iFunc)
    # Define upper and lower limit
    a_reactive <- reactive({input$lower_limit})
    a <- a_reactive()
    #print(a)
    b_reactive <- reactive({input$upper_limit})
    b <- b_reactive()
    #print(b)

    # Define the number of partitions
    n_reactive <- reactive({input$partition_num})
    n <- n_reactive()
    
    f <- function(x) {
      # Define your function here in terms of x
   
      eval(parse(text = iFunc))
    }
    
    
    
  })
  
  
  
  
  

  #get points from a to b
  pts <- seq(a,b,by=.1)



  #represent y as function of x
  y <- f(pts)

  #store points as a data frame
  points <- data.frame(
    x = pts,
    y = y
  )



  # Calculate the width of each partition (dx)
  width <- (b - a) / n


  shape <- data.frame(
    xleft = seq(a, b - width, by = width),
    xright = seq(a + width, b, by = width),
    lHeight = f(seq(a, b - width, by = width)),
    rHeight = f(seq(a + width, b, by = width))
  )
  print(width)
  print(shape$xleft)
  print(shape$xright)
  #print(shape$lHeight)
  #print(shape$rHeight)

  shape$area <- f((shape$xleft + shape$xright)/2) * width
  print(shape$area)
  totalArea <- cumsum(shape$area)
  print(totalArea)
  midpointEstimate = totalArea[length(shape$area)]
  output$result = renderPrint({midpointEstimate})
  #print(midpointEstimate)
  output$midPlot <- renderPlot({
    ggplot() +
      geom_rect(
        data = shape,
        aes(xmin = xleft, xmax = xright, ymin = a, ymax = ((rHeight+lHeight)/2)),
        fill = "pink", color = "black"
      ) +
      geom_line(
        data = points,
        aes(x, y)
      ) +
      theme_minimal()
  })
}