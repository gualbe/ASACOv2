library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("ASACO v2"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "gene",
                        label = "Gene name: ", 
                        choices = seed_genes,
                        selected = "SMN1",
                        width = "150px"),
            actionButton(inputId = "search",
                         label = "Search candidates"), br(), br(),
            selectInput(inputId = "geneTypes", 
                        label = "Gene types:", 
                        choices = gene_types, 
                        multiple = T, 
                        selected = "protein_coding"),
            checkboxInput(inputId = "parallelized", "Multi-thread execution?", FALSE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Direct", br(),
                               downloadButton("downloadDirect", "Download"), br(), br(),
                               DT::dataTableOutput("direct")),
                      tabPanel("Inverse", br(),
                               downloadButton("downloadInverse", "Download"), br(), br(),
                               DT::dataTableOutput("inverse"))
          )
        )
    )
))
