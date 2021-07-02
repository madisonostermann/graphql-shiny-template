## Tab Items

source('page/ui.R', local = TRUE)
page <- tabItem(tabName = "page", page.box)

body <- dashboardBody( 
     tabItems(
          page
     )
)