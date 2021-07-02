page.box <- fluidPage(theme="simplex.min.css",
                           tags$style(type="text/css", "label {font-size: 12px;}", ".recalculating {opacity: 1.0;}"),
                           useShinyjs(),
                           tags$h2("Page"),
                           DT::dataTableOutput("table")
)