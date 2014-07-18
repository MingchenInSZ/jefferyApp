
library(shiny)

shinyUI(pageWithSidebar(
  
     headerPanel(h2("Exploratory data analysis")),
     sidebarPanel(
         selectInput("dataset","Choose a dataSet:",choices=c("iris","mtcars")),
         htmlOutput("varibales"),
         helpText("Just select two variables to show; if more selected,the two former are selected as default"),
         downloadButton("download","Download"),
         helpText("Download the dataset by click the Dwonload button")
       
       ),
     mainPanel(
       tabsetPanel(
         
       tabPanel("dataview",dataTableOutput("table")),
       tabPanel("summary",verbatimTextOutput("summary")),
       tabPanel("plotview",plotOutput("plot"))
       )
       )
  
  ))