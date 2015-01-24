library(shiny)

#
# Title: Shiny Application to display the Storm Data Impact on US Population/Property 1950-2011
# Author: Sathish Duraisamy
# Date: Jan 24, 2015
#

shinyUI(pageWithSidebar(
    headerPanel("Impact of Storm Events on Humans/Propery in US for years 1950-2011"),

    sidebarPanel(
        radioButtons(inputId='impact_on', label = h3('Select the Impact on:'),
                     choices = c("Human Life/Injury" = 1, "Property/Crops" = 2),
                     selected = 1),
        numericInput(inputId="top_n", label='Display top N severe events:',
                     value=5, min=5, max=15, step=5),
        submitButton(text = "Go")
    ),
    mainPanel(
        p("Note: The Storm/Weather data used in this app is a filtered extract of much
           detailed dataset obtained from U.S. National Oceanic and Atmospheric
          Administration ", a("(NOAA)", href="http://www.noaa.gov/"),
                " storm database"),
        br(),
        fluidRow(
            plotOutput('plot')
        ),
        fluidRow(
            br(), hr(),
            h2(textOutput("top_n_txt")),
            tableOutput('top_n_events')
        )
    )
))

