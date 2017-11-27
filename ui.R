
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Demonstration of the Secretary Problem"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("sample_size",
                  "Sample Size:",
                  min = 3,
                  max = 20,
                  value = 3),
      submitButton("Submit")
    ),
    
   

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("opstopPlot"),
      includeHTML("dirs.html")
    )
  )
))
