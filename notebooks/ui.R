#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#



library(shiny)

# Define UI for application 
ui <- fluidPage(
  titlePanel("FurEver Finder"),
  sidebarLayout(
    sidebarPanel(
      selectInput("animal_type", "Select your new friend:",
                  choices = c("Select animal" = "", unique(animals$Type)),
                  selected = ""),
      sliderInput("bins",
                  "Choose Number of Breeds Ranked by Length of Stay:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("OutcomeType", label = "Outcome Type Selection:",
                  choices = c("All", sort(unique(animals$Outcome.Type)))),
      width = 3
    ),
    mainPanel(
      fluidRow(
        column(width = 6,
               wordcloud2Output("breed_wordcloud",width = "100%")),
        column(width = 6,
               plotOutput("avgTime"))
      ),
      fluidRow(
        column(width = 12,
               dataTableOutput("SelectedData"))
      ),
      width = 9
    )
  )
)
