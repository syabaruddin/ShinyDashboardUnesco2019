




#header---------------------------------------------------------------------------
header <-
  dashboardHeader(title = "UNESCO World Heritage Sites 2019",
                  titleWidth = 400)






#sidebar--------------------------------------------------------------------------
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    text = "Global",
    tabName = "global",
    badgeLabel = "dashboard",
    badgeColor = "blue",
    icon = icon("globe-americas")
  ),
  
  menuItem(
    text = "Country",
    tabName = "country",
    badgeLabel = "dashboard",
    badgeColor = "blue",
    icon = icon("globe-americas")
  ),
  
  menuItem(
    text = "Distribution",
    tabName = "map",
    badgeLabel = "map",
    badgeColor = "blue",
    icon = icon("globe-americas")
  ),
  
  menuItem(
    text = "Data",
    tabName = "data",
    badgeLabel = "table",
    badgeColor = "blue",
    icon = icon("table")
  )
  
))



#body ----------------------------------------------------------------------------
body <- dashboardBody(tabItems(
  tabItem(tabName = "global",
          
          fluidRow(
            box(
              title = "Sites Status Overview By Region",
              width = 6,
              
              radioButtons(
                inputId = "regional",
                label = "Please Select the Region",
                choices = unique(whc$region),
                inline = T
              ),
              
              valueBoxOutput(outputId = "numsites", width = 6),
              
              valueBoxOutput(outputId = "numdanger", width = 6)
              
              
              
            ),
            box(
              title = "Sites Status Overview By Category",
              width = 6,
              
              radioButtons(
                inputId = "kategori",
                label = "Please Select the category",
                choices = unique(whc$category),
                inline = T
                
              ),
              
              valueBoxOutput(outputId = "num_kategori", width = 6),
              
              valueBoxOutput(outputId = "num_katdang", width = 6),
              
              
            )
            
          ),
          
          
          
          fluidRow(
            box(
              title = "World Heritage Sites Registered by Year",
              width = 6,
              
              selectInput(
                inputId = "register",
                label = "Select the Region:",
                choices = unique(whc$region)
                
              ),
              plotlyOutput("registerglobal")
            ),
            
            box(
              title = "World Heritage Sites by Category Per Region",
              width = 6,
              selectInput(
                inputId = "categorical",
                label = "Select the Category:",
                choices = unique(whc$category)
                
              ),
              plotlyOutput("categoricalglobal")
            ),
            
            
          )),
  
  tabItem(tabName = "country",
          
          fluidRow(
            box(
              title = "Sites Status Overview By Country",
              width = 6,
              
              selectInput(
                inputId = "neg",
                label = "Please Select the Region",
                choices = unique(whc$region)
                
              ),
              
              valueBoxOutput(outputId = "coneg", width = 12)
            ),
            
            box(
              title = "Sites Status Overview By Country",
              width = 6,
              
              selectInput(
                inputId = "negara",
                label = "Please Select the Country",
                choices = unique(whc$country),
                selected = "Indonesia"
                
                
              ),
              
              valueBoxOutput(outputId = "cosites", width = 12)
            )
            
            
          ),
          
          fluidRow(
            box(
              title = "Top 10 Countries per Region With The Highest Number of Sites",
              width = 12,
              
              radioButtons(
                inputId = "regcount",
                label = "Select the Region:",
                choices = unique(whc$region),
                selected = "Africa",
                inline = T
                
              ),
              plotlyOutput("registercount")
            )
            
            
          )),
  
  tabItem(tabName = "map",
          
          fluidRow(
            box(
              title = "World Heritage Sites Distribution Map",
              "Zoom and hover the icon to check the name of the site",
              width = 12,
              
              height = "100%",
              leafletOutput("mapglobal", width = "100%", height = 800)
            )
            
          )),
  
  
  tabItem(tabName = "data",
          
          fluidRow(
            box(
              title = "Data Source",
              width = 12,
              
              dataTableOutput("datatable")
            )
            
          ))
))


































#dashboard-----------------------------------------------------------------------

dashboardPage(header, sidebar, body, skin = "blue")
