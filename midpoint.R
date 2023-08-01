#ggplot2 library
library(ggplot2)
midpoint <- function(input, output){
  
  
  observeEvent(input$calculate_btn,{
    iFunc <- reactive({input$input_func})

    # Define upper and lower limit
    a_reactive <- reactive({input$lower_limit})
    a <- a_reactive()
  
    b_reactive <- reactive({input$upper_limit})
    b <- b_reactive()
    

    # Define the number of partitions
    n_reactive <- reactive({input$partition_num})
    n <- n_reactive()
    
    f <- function(x,func) {
      # Define your function here in terms of x
   
      eval(parse(text = func))
    }
    
    #get points from a to b
    pts <- seq(a,b,by=.1)
    
    
    
    #represent y as function of x
    y <- f(pts,iFunc())
    
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
      lHeight = f(seq(a, b - width, by = width),iFunc()),
      rHeight = f(seq(a + width, b, by = width), iFunc())
    )

    
    shape$area <- f((shape$xleft + shape$xright)/2, iFunc()) * width
    
    totalArea <- cumsum(shape$area)
    
    midpointEstimate = totalArea[length(shape$area)]
    print(midpointEstimate)
    output$result = renderText({paste("Midpoint Estimate:",midpointEstimate)})

    
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
        theme_minimal()+
        coord_fixed()
    })
    
  })
  
  
  
}
