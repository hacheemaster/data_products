library(shiny)
data(mtcars)

#properly assign factor variables
factor_vars <- c("cyl", "vs", "am", "gear", "carb")
for (var in factor_vars){
    mtcars[var] <- as.factor(mtcars[[var]])
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    #create text summary
    output$summary <- renderPrint({
        summary(mtcars)
    })
    
    #create conditional diagnostic plot
    output$distPlot <- renderPlot({
        formuula <- paste0(input$target,"~.")
        fit <- lm(as.formula(formuula),data=mtcars)
        
        # diagnostic plots 
        layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
        plot(fit)
    })
    
    #create results output
    output$results <- renderPrint({
        formuula <- paste0(input$target,"~.")
        fit <- lm(as.formula(formuula),data=mtcars)
        summary(fit)$r.squared
    })
    
})