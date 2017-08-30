#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic.
shinyServer(function(input, output) {
  # choose columns to display
  trainingSet2 = trainingSet
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(trainingSet2[, input$show_vars, drop = FALSE], options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })

  
  output$plot1 <- renderPlot({
    ggplot(reducedTrainingSet, 
           aes(x = firstLetterName, 
               y = Age, 
               color = factor(Survived, labels = c("No", "Yes")),
               shape = Pclass)) +
      geom_point() +
      ylab("Age in years") +
      scale_x_discrete("Names in Alphabetical Order", breaks=LETTERS[1:26]) +
      scale_y_continuous(breaks=seq(0,90,5)) +
      labs(color = "Survivor", shape = "Ticket Class") +
      coord_cartesian(ylim = c(0, 80))
  }, width = 600)
  
  output$click_info <- renderPrint({
    # Because it's a ggplot2, we don't need to supply xvar or yvar; if this
    # were a base graphics plot, we'd need those.
    nearPoints(reducedTrainingSet, input$plot1_click, threshold = 5, maxpoints = 3)
  })
  
  output$brush_info <- renderPrint({
    brushedPoints(reducedTrainingSet, input$plot1_brush)
  })
  
})
