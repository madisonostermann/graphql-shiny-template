server <- function(input, output, session) {
    # Page Tab
    source("page/server.R", local = TRUE)

    # Establish link and connection to GraphQL endpoint
    link <<- 'http://localhost:4000/'
    conn <<- GraphqlClient$new(url = link)

    # Function to run a GraphQL query
    execute_query = function(query) {
        result <- conn$exec(Query$new()$query('link', query)$link)
        flat_result <- result %>% fromJSON(flatten = F)
        # print(flat_result)
        result.df <- as.data.frame(flat_result[[1]])
        # print(result.df)
        output$table <- DT::renderDataTable({result.df}, rownames = TRUE, filter = 'top', selection = 'single', extensions = 'Buttons')
    }

    # Run a query
    execute_query('
    query SampleQuery {
    actors{
        name 
        birthday
        num_movies
    }
    }
    ')
    
    ########## TIDY UP AT END OF SESSION ##########

    session$onSessionEnded(function() {
        removeModal()
        link <<- NULL
        conn <<- NULL
    })
    
}
