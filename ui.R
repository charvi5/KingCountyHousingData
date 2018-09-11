

dashboardPage(
              
              dashboardHeader(title = 'House sales in King County, USA',
                              titleWidth = 400),
              
              dashboardSidebar(
                tags$head(
                  tags$style(HTML("
                                  .content-wrapper {
                                  background-color: linen !important;
                                  }
                                  .main-sidebar {
                                  background-color: navyblue !important;
                                  }
                                  "))),
                width = 250,
                tags$head(
                          tags$style(HTML(" .sidebar { position:fixed; width:250px;
                                     white-space:nowrap; overflow:visible; height: 100vh; overflow-y: auto;}
                                     " )
                          )
                        ),
                  
                dateRangeInput('date','Sold date',
                               start = min(HouseData$date),
                               end = max(HouseData$date)
                               ),
                
                sliderInput('price', 'Price Range', min = min(HouseData$price)
                            , step = 100000
                            , max = max(HouseData$price), value = c(400000, 2000000)),
                
                sliderInput('bltyr', 'Built Year',
                            min = min(HouseData$yr_built), max = max(HouseData$yr_built),
                            c(1960, 2010), sep = ""),
                hr(),
                
                sliderInput('homesqft', 'Home size (sqft)',
                            min = min(HouseData$sqft_living), max = max(HouseData$sqft_living),
                            value = c(1000,3000)),
                
                sliderInput('lotsqft', 'Lot size (sqft)',
                            min = min(HouseData$sqft_lot), max = max(HouseData$sqft_lot),
                            value = c(3000, 800000)),
                hr(),
                
                selectizeInput('bedrooms','Bedrooms',
                               multiple = TRUE, choices = unique(HouseData$bedrooms),
                               selected = 2),
                
                selectizeInput('bathrooms', 'Bathrooms',
                               multiple = TRUE, choices = unique(HouseData$bathrooms),
                               selected = 2),
                
                selectInput('floors','Floors', choices = unique(HouseData$floors),
                            selected = 2),
                
                checkboxInput('waterfront', 'Has waterfront?',
                              value = FALSE),
                
                hr()
                
                ),
              
              dashboardBody(
                tabsetPanel(tabPanel(
                  strong('House locations'),
                  br(),
                  p('This dashboard shows Housing data in King County, USA.',
                    'The data has been sourced from:',
                    a('https://www.kaggle.com/harlfoxem/housesalesprediction')),
                  leafletOutput('housingmap'),
                  hr(),
                  valueBoxOutput('meanprice'),
                  valueBoxOutput('medianprice'),
                  value = 1
                ),
                
                tabPanel(
                  strong('Housing data [full]'),
                  br(),
                  actionButton('submit','Submit',icon = icon('refresh')),
                  downloadButton('downloadfile','Download',icon = icon('download')),
                  br(),
                  br(),
                  dataTableOutput('housingdata'),
                  value = 2
                  
                ), id = 'tabVals')
               
                
              )
                )