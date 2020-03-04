library(shiny)
library(DT)

shinyApp(
  ui = fluidPage(
    dataTableOutput('table'),
    verbatimTextOutput('hoverIndex')
  ),
  
  server = function(server, input, output) {
    
    output$hoverIndex <- renderText({
      paste("hover column info", input$hoverIndexJS)
    })
    
    output$table <- renderDataTable({
      datatable(data.frame(`A` = 1:5, `B` = 11:15, `C` = LETTERS[1:5]),
                rownames = F,
                callback = JS("
                              table.on('mouseenter', 'td', function() {
                              Shiny.onInputChange('hoverIndexJS', this.innerHTML);
                              });
                              return table;
                              ")
                )
  })
  }
                )