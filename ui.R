

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
  pageWithSidebar(
    headerPanel("Preguntas Frecuentes Ada"),
    sidebarPanel(
      p("Elije una opción"),
      selectInput("x", "Selecciona el eje de las X",
                  choices = c("Preguntas mas frecuentes","preguntas menos frecuentes"))
      
      ),
    mainPanel(h3(textOutput("output_text")),
            plotOutput("output_plot") 
              )
  )
)

#ejecutar con shiny::runApp('serverR/preggfeq',port=3374)