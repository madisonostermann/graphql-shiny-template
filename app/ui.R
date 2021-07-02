source("header.R")
source("sidebar.R")
source("body.R")

ui <- fluidPage(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tags$head(uiOutput("css")),
    tags$head(tags$style(".centerAlign{float:center;}")),
    dashboardPage(
        skin = "black",
        header,
        sidebar,
        body
    ),
)