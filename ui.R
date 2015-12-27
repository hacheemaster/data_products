library(shiny)
data(mtcars)

targets <- c("mpg", "disp", "hp", "drat", "wt", "qsec")
factor_vars <- c("cyl", "vs", "am", "gear", "carb")
for (var in factor_vars){
    mtcars[var] <- as.factor(mtcars[[var]])
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Automating model building"),
    
    h4("Documentation:"),
    textOutput("text1"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("target", "Target variable:",
                        choices = targets),
            checkboxInput("diagnostics", "Show Diagnostics", TRUE)
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h4("Summary:"),
            verbatimTextOutput("summary"),
            conditionalPanel(
                condition = "input.diagnostics == true",
                    h4("Diagnostics:"),
                    plotOutput("distPlot")
            ),
            h4("R-squared:"),
            verbatimTextOutput("results")
        )
    )
))