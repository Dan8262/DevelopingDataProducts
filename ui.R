#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = "project.css",
  
  # Application title
  titlePanel("DEVELOPING DATA PRODUCTS WEEK 4 PROJECT"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(width = 3,
      conditionalPanel(
        condition="input.conditionedPanels == 'Intro'",
        HTML("<strong>THE TITANIC PROJECT</strong>")
      ),
      conditionalPanel(
        condition="input.conditionedPanels == 'Data Content'",
        checkboxGroupInput("show_vars", "Variables in data set to show:",
                           names(trainingSet), selected = names(trainingSet)),
        hr(),
        helpText("Click the column header to sort a column."),
        hr(),
        helpText("Display 5 records by default.")
      ),
      conditionalPanel(
        condition="input.conditionedPanels == 'Basic Exploratory'",
        helpText("Click/Brush on one or several points to display their identity."),
        HTML("<hr />"),
        helpText("Note: Click action selects up to three points.")
      )
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Intro", 
                 h2("The History"),
                 p("The sinking of the RMS Titanic is one of the most infamous shipwrecks in history.  On April 15, 1912, during her maiden voyage, the Titanic sank after colliding with an iceberg, killing 1502 out of 2224 passengers and crew. This sensational tragedy shocked the international community and led to better safety regulations for ships."),
                 p("One of the reasons that the shipwreck led to such loss of life was that there were not enough lifeboats for the passengers and crew. Although there was some element of luck involved in surviving the sinking, some groups of people were more likely to survive than others, such as women, children, and the upper-class."),
                 h2("Synopsis"), 
                 p("This Shiny application downloads the Titanic training set, displays it and performs very basic exploratory operations on it."),
                 p("This application runs Data Tables Options, Tabsets, Reactivity and Plot Interaction Shiny components; some CSS is also included.")
                ), 
        tabPanel("Data Content", 
                 h2("Data Set Content"),
                 DT::dataTableOutput("mytable1")), 
        tabPanel("Basic Exploratory", 
                 h2("Basic Exploratory"),
                 fluidRow(
                   column(width = 12,
                          plotOutput("plot1", height = 500, width = "100%",
                                     click = "plot1_click",
                                     brush = brushOpts(id = "plot1_brush")
                                    ) # plotOutput
                 
                         ) # column
                 ) # fluidRow
                ,
               fluidRow(
                  column(width = 12,
                         h4("Points near click"),
                         verbatimTextOutput("click_info")
                        ) # column
                       ), # fluidRow
              fluidRow(
                  column(width = 12,
                         h4("Brushed points"),
                         verbatimTextOutput("brush_info")
                        ) # column
                      ) # fluidRow
                 ), # tabPanel "Basic Exploratory"
        id = "conditionedPanels"
      ) # tabsetPanel
    ) # mainPanel
  )
))
