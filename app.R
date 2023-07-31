#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that asks for user input
ui <- fluidPage(

    # Application title
    titlePanel("Midpoint Rule Calculator"),

    sidebarLayout(
        sidebarPanel(
            func <-textInput("input_func",
                label = "Function (in terms of x)", 
                value = "x^2", 
                width = "45%"
            ),
            partitions <-numericInput("partition_num",
                label = "Number of Partitions", 
                value = 4, 
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

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("midPlot"),
           verbatimTextOutput("result")
        )
    )
)

# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#     output$midPlot <- renderPlot({
#         
#     })
# }
source("midpoint.R")

# Run the application 
shinyApp(ui = ui, midpoint)
