
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

library(ggplot2)
library(dplyr)
library(magrittr)

prob <- function(k, n){
  j <- seq(k+1,n)
  res <- (k/n)*sum(1/(j-1))
  return(res)
}


data <- function(n){
  res0 <- factorial(n-1)/factorial(n)
  resk <- sapply(seq(1,n-1), prob, n=n)
  sample <- c(1:n-1)
  prob <- c(res0, resk)
  x <- data.frame(sample, prob) %>% mutate(is_max = sample == sample[which.max(prob)])
}

run_sim <- function(n){
  t <- data(n)
}

shinyServer(function(input, output) {
  simDating <- reactive({
    run_sim(n = input$sample_size)
  })

  output$opstopPlot <- renderPlot({
    t <- simDating()
    n <- input$sample_size
    chart_title <- paste("Optimal Sample Size for Secretary Puzzle N = ", number = list(n))
    p <- ggplot(data=t, aes(x=sample, y=prob, fill = is_max)) + geom_bar(stat = "identity") +
      scale_fill_manual(values = c("FALSE" = "steelblue", "TRUE" = "red")) + 
      theme(legend.position="none") + 
      labs(x = 'Samples', y = 'Probability of Success')
    p + ggtitle(bquote(atop(.(chart_title), "")))
  })
  

})
