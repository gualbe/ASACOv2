library(shiny)
library(DT)
library(data.table)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  candidates <- eventReactive(input$search, {
    res = readOutputs(input$gene)
    if (is.null(res)) {
      filename = paste0("input_genes/", input$gene, ".tsv")
      #cl = cluster()
      withProgress(message = 'Scoring candidates', value = 0, {
        res = selgenes_file(filename)
      })
      #stopCluster(cl)
    }
    res
  }, ignoreNULL = FALSE)
  
  output$direct <- DT::renderDataTable({   # renderTable(
    candidates()$direct_scores
  })

  output$inverse <- DT::renderDataTable({
    candidates()$inverse_scores
  })
  
  output$downloadDirect <- downloadHandler(
    filename = function() {
      paste(input$gene, "_direct_scores.csv", sep = "")
    },
    content = function(file) {
      fwrite(candidates()$direct_scores, file)
    }
  )
  
  output$downloadInverse <- downloadHandler(
    filename = function() {
      paste(input$gene, "_inverse_scores.csv", sep = "")
    },
    content = function(file) {
      fwrite(candidates()$inverse_scores, file)
    }
  )
  
})
