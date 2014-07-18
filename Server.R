
library(shiny)
library(datasets)
library(ggplot2)
shinyServer(function(input,output){
      datasetInput<-reactive({
        switch(input$dataset,
               'iris'=iris,
               'mtcars'=mtcars
          )
        
      })
      
      classes<-function(){
        outc<-factor()
        if(input$dataset=='iris')
        {
          outc<-iris$Species
        }else{
          
          outc<-factor(mtcars$cyl)
        }
        outc
      }
      showNames<-function(){
        ns<-c()
        if(input$dataset=="iris")
        {
          name<-names(iris)
          ns<-name[1:length(name)-1]
        }else{
          
          name<-names(mtcars)
          ns<-c(name[1],name[3:length(name)])
        }
        ns
      }
     
      output$varibales<-renderUI({
        checkboxGroupInput("var","Select two variables to plot:",choices=showNames(),selected=head(showNames(),2))
        
        })
      output$table<-renderDataTable({
        datasetInput()
      },, options = list(bSortClasses = TRUE))
      output$summary<-renderPrint({
        summary(datasetInput())
      })
      output$plot<-renderPlot({
        dataset<-datasetInput()
        attach(dataset)
        qplot(x=get(input$var[1]),y=get(input$var[2]),data=dataset,color=classes(),xlab=input$var[1],ylab=input$var[2],main="Differences in groups")
      })
      output$download <- downloadHandler(
        filename = function() { paste(input$dataset, '.csv', sep='') },
        content = function(file) {
          write.csv(datasetInput(), file)
        }
      )
  })