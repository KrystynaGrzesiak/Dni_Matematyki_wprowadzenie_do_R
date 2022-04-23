
library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  numericInput("n", "Wpisz liczbę wierszy", value = 100),
  plotOutput("wykres")
)

server <- function(input, output, session) {
  
  output[["wykres"]] <- renderPlot({
    iris[1:input[["n"]], ] %>% 
      ggplot(aes(x = Petal.Length, y = Petal.Width, col = Species)) +
      geom_point()
  })
  
}

shinyApp(ui, server)

