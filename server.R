

library(mongolite)
library(RMongo)
library(dplyr)
library(ggplot2)
library(shiny)

sat_collection = mongo(collection = "usuarios",
                       db = "interacciones")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$output_text <- renderText(paste("Grafico de ",input$x))


  output$output_plot <- renderPlot(
    
    if(input$x == "Preguntas mas frecuentes"){
      sat_collection$aggregate('[{"$group":{"_id":"$Intencion","Count":{"$sum":1}}}]') %>% na.omit()%>%
        arrange(desc(Count))%>% head(10) %>%
        ggplot(aes(x=reorder(`_id`,Count),y=Count))+
        geom_bar( stat = "identity", fill="#E5BDFF")+
        geom_text(aes(label= Count),color ="black")+
        coord_flip() + xlab("Intenciones") + ylab("veces")
    }else{
      tail( sat_collection$aggregate('[{"$group":{"_id":"$Intencion","Count":{"$sum":1}}}]') %>% na.omit()%>%
              arrange(desc(Count)), 10) %>%
        ggplot(aes(x=reorder(`_id`,Count),y=Count))+
        geom_bar( stat = "identity", fill="#E5BDFF")+
        geom_text(aes(label= Count),color ="black")+
        coord_flip() + xlab("Intenciones") + ylab("veces")
      
    }
    
   
  )
  
  
})
