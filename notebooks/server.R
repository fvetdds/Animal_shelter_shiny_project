#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
 function(input, output, session) {
   filtered_animals <- reactive ({
     req(input$animal_type)
     animals %>%
       filter(Type == input$animal_type)
   })
   
   

# Render word cloud of breeds
output$breed_wordcloud <- renderWordcloud2({
  data <- filtered_animals() %>%
    count(Breed) %>%
    arrange(desc(n))
  wordcloud2(data, size = 1.0)})

# Render average time in shelter bar chart
output$avgTime <- renderPlot({
  data <- filtered_animals() %>%
    group_by(Breed) %>%
    summarize(avg_days_in_shelter = mean(Days.in.Shelter, na.rm = TRUE)) %>%
    arrange(desc(avg_days_in_shelter)) %>%
    head(input$bins)
  
  ggplot(data, aes(x = reorder(Breed, avg_days_in_shelter), y = avg_days_in_shelter)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(x = "Breed", y = "Average Days in Shelter") +
    theme_minimal()
})

# Render data table of selected animal outcome information 
output$SelectedData <- renderDataTable({
  data <- filtered_animals()
  if (input$OutcomeType != "All") {
    data <- data %>% filter(Outcome.Type == input$OutcomeType)
  }
  datatable(data, options = list(order = list(5,'desc')))
})
} 
