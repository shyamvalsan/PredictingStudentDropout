library(RColorBrewer)

function(input, output, session) {
  
  ## Visualize the data ##3############################################
  output$plot <- renderPlotly({
    plot_ly(data, x = ~MarriedBelowLegalAgeFemales, y = ~Class5DropOutRate, color = ~ChildLabour, size = ~size, colors = colors,
            type = 'scatter', mode = 'markers', sizes = c(min(data$size), max(data$size)),
            marker = list(symbol = 'circle', sizemode = 'radius',
                          line = list(width = 2, color = '#FFFFFF')),
            text = ~paste('District:',District,
                          '<br>Students per teacher:', StudentTeacherRatio, 
                          '<br>Percentage of children engaged in child labour:', ChildLabour, 
                          '<br>Percentage of girls married before 18:', MarriedBelowLegalAgeFemales,
                          '<br>Percentage of dropouts by class 5:', Class5DropOutRate)) %>%
      layout(title = 'Visualize',
             xaxis = list(title = 'Percentage of girls married before 18',
                          gridcolor = 'rgb(255, 255, 255)',
                          range = c(-1, 30),
                          zerolinewidth = 1,
                          ticklen = 1,
                          gridwidth = 2),
             yaxis = list(title = 'Percentage of students dropping out by class 5',
                          gridcolor = 'rgb(255, 255, 255)',
                          range = c(-1, 50),
                          zerolinewidth = 1,
                          ticklen = 5,
                          gridwith = 2),
             paper_bgcolor = 'rgb(243, 243, 243)',
             plot_bgcolor = 'rgb(243, 243, 243)')
  })
  
  output$event <- renderPrint({
    d <- event_data("plotly_hover")
  })
  
  ## Predict Dropout Rate based on user input#############################
  
  values <- reactiveValues()
  
  newEntry <- observe({ # use observe pattern
    
    x=as.data.frame(matrix(0, nrow=1, ncol=10))
    colnames(x)=c("EffectiveLiteracyRate","MarriedIlliterateWomen","SexRatio","MarriedBelowLegalAgeFemales","Schooling","ChildLabour","AvgTeachersPerSchool","StudentTeacherRatio","StudentClassroomRation","Class5DropOutRate")
    
    x[1,1]=as.numeric(input$EffectiveLiteracyRate)
    x[1,2]=as.numeric(input$MarriedIlliterateWomen)
    x[1,3]=as.numeric(input$SexRatio)
    x[1,4]=as.numeric(input$MarriedBelowLegalAgeFemales)
    x[1,5]=as.numeric(input$Schooling)
    x[1,6]=as.numeric(input$ChildLabour)
    x[1,7]=as.numeric(input$AvgTeachersPerSchool)
    x[1,8]=as.numeric(input$StudentTeacherRatio)
    x[1,9]=as.numeric(input$StudentClassroomRation)
    x[1,10]=as.numeric(predict(brnn_shm, x[-length(x)]))
    x <- format(x, digits=2, nsmall=2)

    isolate(values$df <- as.vector(x[1,10]))
    
  })
  output$dropout <- renderText(paste0("Predicted Dropout Rate: ",values$df,"%"))

  ## Explore Raw Data ###########################################
  output$mytable = DT::renderDataTable({zipdata1})
  
}