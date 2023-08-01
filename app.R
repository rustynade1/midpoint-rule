library(shiny)
library(ggplot2)

# Define UI for application that asks for user input
ui <- fluidPage(

    # Application title
    titlePanel("Midpoint Rule Calculator"),
    # Sidebar with default values
    sidebarLayout(
        sidebarPanel(
            func <-textInput("input_func",
                label = "Function (in terms of x)", 
                value = "x^2", 
                width = "45%"
            ),
            partitions <-numericInput("partition_num",
                label = "Number of Partitions", 
                value = 8, 
                width = "45%"
            ),
            uLimit <-numericInput("upper_limit",
                label = "Upper Limit", 
                value = 1, 
                width = "45%"
            ),
            lLimit <-numericInput("lower_limit",
                label = "Lower Limit", 
                value = 0, 
                width = "45%"
            ),
            calcButton <-actionButton("calculate_btn", "Calculate")
        ),

        # shows visual representation and estimate result
        mainPanel(
           plotOutput("midPlot"),
           textOutput("result")
        )
    )
)

#Define server logic

source("midpoint.R")

# Run the application 
shinyApp(ui = ui, midpoint)
